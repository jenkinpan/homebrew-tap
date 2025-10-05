#!/usr/bin/env bash

# Script to validate Homebrew formulae in this tap
# Usage: ./scripts/validate-formulae.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TAP_DIR="$(dirname "$SCRIPT_DIR")"
FORMULA_DIR="$TAP_DIR/Formula"

echo "🔍 Validating Homebrew formulae..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter for errors and warnings
ERRORS=0
WARNINGS=0

# Function to check if a formula file exists
check_formula_exists() {
    local formula=$1
    if [[ ! -f "$FORMULA_DIR/$formula.rb" ]]; then
        echo -e "${RED}✗${NC} Formula not found: $formula.rb"
        ((ERRORS++))
        return 1
    fi
    echo -e "${GREEN}✓${NC} Formula exists: $formula.rb"
    return 0
}

# Function to check formula syntax
check_formula_syntax() {
    local formula=$1
    local formula_file="$FORMULA_DIR/$formula.rb"

    # Check if Ruby can parse the file
    if ruby -c "$formula_file" > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} Ruby syntax valid: $formula.rb"
    else
        echo -e "${RED}✗${NC} Ruby syntax error: $formula.rb"
        ruby -c "$formula_file"
        ((ERRORS++))
        return 1
    fi
    return 0
}

# Function to check required fields
check_required_fields() {
    local formula=$1
    local formula_file="$FORMULA_DIR/$formula.rb"

    echo "  Checking required fields..."

    # Check for desc
    if grep -q 'desc "' "$formula_file"; then
        echo -e "    ${GREEN}✓${NC} Has description"
    else
        echo -e "    ${RED}✗${NC} Missing description"
        ((ERRORS++))
    fi

    # Check for homepage
    if grep -q 'homepage "' "$formula_file"; then
        echo -e "    ${GREEN}✓${NC} Has homepage"
    else
        echo -e "    ${RED}✗${NC} Missing homepage"
        ((ERRORS++))
    fi

    # Check for version
    if grep -q 'version "' "$formula_file"; then
        echo -e "    ${GREEN}✓${NC} Has version"
    else
        echo -e "    ${YELLOW}⚠${NC} Missing explicit version"
        ((WARNINGS++))
    fi

    # Check for license
    if grep -q 'license "' "$formula_file"; then
        echo -e "    ${GREEN}✓${NC} Has license"
    else
        echo -e "    ${YELLOW}⚠${NC} Missing license"
        ((WARNINGS++))
    fi

    # Check for url
    if grep -q 'url "' "$formula_file"; then
        echo -e "    ${GREEN}✓${NC} Has download URL"
    else
        echo -e "    ${RED}✗${NC} Missing download URL"
        ((ERRORS++))
    fi

    # Check for install method
    if grep -q 'def install' "$formula_file"; then
        echo -e "    ${GREEN}✓${NC} Has install method"
    else
        echo -e "    ${RED}✗${NC} Missing install method"
        ((ERRORS++))
    fi

    # Check for test block
    if grep -q 'def test' "$formula_file" || grep -q 'test do' "$formula_file"; then
        echo -e "    ${GREEN}✓${NC} Has test block"
    else
        echo -e "    ${YELLOW}⚠${NC} Missing test block"
        ((WARNINGS++))
    fi
}

# Function to check URL format
check_url_format() {
    local formula=$1
    local formula_file="$FORMULA_DIR/$formula.rb"

    echo "  Checking URL format..."

    # Extract URLs and check format
    local urls=$(grep -o 'url "https://[^"]*"' "$formula_file" || true)

    if [[ -n "$urls" ]]; then
        while IFS= read -r url; do
            # Remove quotes
            url=$(echo "$url" | sed 's/url "//;s/"//')

            # Check if URL contains version interpolation
            if echo "$url" | grep -q '#{version}'; then
                echo -e "    ${GREEN}✓${NC} URL uses version interpolation"
            else
                echo -e "    ${YELLOW}⚠${NC} URL doesn't use version interpolation (consider using \#{version})"
                ((WARNINGS++))
            fi

            # Check if URL is HTTPS
            if [[ "$url" == https://* ]]; then
                echo -e "    ${GREEN}✓${NC} URL uses HTTPS"
            else
                echo -e "    ${RED}✗${NC} URL doesn't use HTTPS: $url"
                ((ERRORS++))
            fi
        done <<< "$urls"
    fi
}

# Function to check class name
check_class_name() {
    local formula=$1
    local formula_file="$FORMULA_DIR/$formula.rb"

    echo "  Checking class name..."

    # Convert formula name to expected class name
    # devtool -> Devtool, pkg-checker -> PkgChecker
    local expected_class=$(echo "$formula" | awk -F'-' '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1' OFS='')

    if grep -q "class $expected_class < Formula" "$formula_file"; then
        echo -e "    ${GREEN}✓${NC} Class name matches: $expected_class"
    else
        echo -e "    ${RED}✗${NC} Class name doesn't match expected: $expected_class"
        echo "    Found: $(grep 'class.*< Formula' "$formula_file")"
        ((ERRORS++))
    fi
}

# Main validation
echo "📋 Formulae to validate:"
formulae=(devtool pkg-checker)
for formula in "${formulae[@]}"; do
    echo "  - $formula"
done
echo ""

# Validate each formula
for formula in "${formulae[@]}"; do
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Validating: $formula"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    if check_formula_exists "$formula"; then
        check_formula_syntax "$formula"
        check_class_name "$formula"
        check_required_fields "$formula"
        check_url_format "$formula"
    fi

    echo ""
done

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Validation Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Errors:   ${RED}$ERRORS${NC}"
echo -e "Warnings: ${YELLOW}$WARNINGS${NC}"
echo ""

if [[ $ERRORS -eq 0 ]]; then
    echo -e "${GREEN}✓ All formulae validated successfully!${NC}"
    if [[ $WARNINGS -gt 0 ]]; then
        echo -e "${YELLOW}⚠ Note: There are $WARNINGS warning(s) to consider${NC}"
    fi
    exit 0
else
    echo -e "${RED}✗ Validation failed with $ERRORS error(s)${NC}"
    exit 1
fi
