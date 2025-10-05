# Homebrew Tap Setup Instructions

This document provides step-by-step instructions for setting up the Homebrew tap and configuring automatic updates.

## Prerequisites

- GitHub account
- Git installed locally
- Access to the `devtool-rs` and `pkg-checker-rs` repositories

## Step 1: Create the Homebrew Tap Repository on GitHub

1. Go to GitHub and create a new repository named `homebrew-tap`
2. **Important**: The repository name must start with `homebrew-` for Homebrew to recognize it as a tap
3. Set the repository to public (Homebrew taps must be public)
4. Do not initialize with README, .gitignore, or license (we already have these locally)

## Step 2: Push Local Repository to GitHub

```bash
cd ~/Documents/homebrew-tap
git add .
git commit -m "Initial commit: Add devtool and pkg-checker formulae"
git branch -M main
git remote add origin https://github.com/jenkinpan/homebrew-tap.git
git push -u origin main
```

## Step 3: Create Personal Access Token (PAT)

To allow the project repositories to trigger updates in the tap:

1. Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token (classic)"
3. Give it a descriptive name like "Homebrew Tap Update Token"
4. Set expiration as needed (recommend: no expiration for automation)
5. Select the following scopes:
   - `repo` (Full control of private repositories)
   - `workflow` (Update GitHub Action workflows)
6. Click "Generate token"
7. **Important**: Copy the token immediately (you won't be able to see it again)

## Step 4: Add Secret to devtool-rs Repository

1. Go to the `devtool-rs` repository on GitHub
2. Navigate to Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Name: `TAP_GITHUB_TOKEN`
5. Value: Paste the Personal Access Token you just created
6. Click "Add secret"

## Step 5: Add Secret to pkg-checker-rs Repository

Repeat the same process for `pkg-checker-rs`:

1. Go to the `pkg-checker-rs` repository on GitHub
2. Navigate to Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Name: `TAP_GITHUB_TOKEN`
5. Value: Paste the same Personal Access Token
6. Click "Add secret"

## Step 6: Test the Setup

### Option 1: Create a New Release (Recommended)

Test with a new version release:

```bash
# In devtool-rs or pkg-checker-rs directory
git tag v0.x.x  # Use appropriate version number
git push origin v0.x.x
```

This will:
1. Trigger the `homebrew-release.yml` workflow
2. Build binaries for all platforms
3. Create a GitHub release with the binaries
4. Calculate SHA256 checksums
5. Automatically trigger the tap update workflow
6. Update the formula in the tap repository

### Option 2: Manual Workflow Dispatch

If you don't want to create a release yet:

1. Go to the `homebrew-tap` repository on GitHub
2. Click on "Actions" tab
3. Select "Update devtool Formula" or "Update pkg-checker Formula"
4. Click "Run workflow"
5. Fill in the required parameters:
   - Version (e.g., 0.4.1)
   - SHA256 checksums for all platforms
6. Click "Run workflow"

## Step 7: Install and Test Locally

Once the tap is set up:

```bash
# Add the tap
brew tap jenkinpan/tap

# Install the tools
brew install jenkinpan/tap/devtool
brew install jenkinpan/tap/pkg-checker

# Test the installation
devtool --version
pkg-checker --version
```

## How the Automatic Update System Works

### Workflow Sequence

1. **Developer Action**: You create a new release in `devtool-rs` or `pkg-checker-rs`
2. **Build Step**: The `homebrew-release.yml` workflow runs and:
   - Builds binaries for all supported platforms
   - Uploads binaries to the GitHub release
   - Calculates SHA256 checksums for each binary
3. **Trigger Step**: Sends a repository dispatch event to `homebrew-tap` with version and checksums
4. **Update Step**: The tap's workflow receives the event and:
   - Updates the formula with new version number
   - Updates SHA256 checksums for all platforms
   - Commits and pushes changes to the tap repository
5. **User Action**: Users can now install the updated version with `brew upgrade`

### Architecture Diagram

```
┌─────────────────┐       ┌─────────────────┐
│  devtool-rs     │       │ pkg-checker-rs  │
│                 │       │                 │
│  New Release    │       │  New Release    │
│  (v0.x.x tag)   │       │  (v0.x.x tag)   │
└────────┬────────┘       └────────┬────────┘
         │                         │
         │ homebrew-release.yml    │
         ▼                         ▼
    Build Binaries            Build Binaries
    Calculate SHA256          Calculate SHA256
         │                         │
         │ repository_dispatch     │
         └─────────┬───────────────┘
                   ▼
         ┌──────────────────┐
         │  homebrew-tap    │
         │                  │
         │  Auto Update     │
         │  Formula         │
         └──────────────────┘
                   │
                   ▼
            Users can install
            brew install jenkinpan/tap/devtool
```

## Troubleshooting

### Issue: Workflow doesn't trigger

**Solution**: 
- Check that `TAP_GITHUB_TOKEN` secret is correctly set
- Verify the token has `repo` and `workflow` scopes
- Check that the repository name in the workflow file matches your actual repository

### Issue: SHA256 mismatch error

**Solution**:
- The checksums are automatically calculated during the build process
- If you see this error, the binary file might be corrupted
- Re-run the release workflow

### Issue: Formula not found

**Solution**:
- Make sure the tap repository is public
- Verify you've run `brew tap jenkinpan/tap`
- Check that the Formula file is in the `Formula/` directory with correct capitalization

### Issue: Binary not found in tarball

**Solution**:
- Verify the binary name in the formula matches the actual binary name
- Check that the tarball contains the binary at the root level (not in a subdirectory)

## Maintenance

### Updating Formula Manually

If you need to update a formula manually:

```bash
cd ~/Documents/homebrew-tap
# Edit the formula file
vim Formula/devtool.rb
# Update version and URLs
git add Formula/devtool.rb
git commit -m "chore: update devtool to vX.Y.Z"
git push
```

### Testing Formula Locally

Before pushing changes:

```bash
brew install --build-from-source ./Formula/devtool.rb
brew test devtool
brew audit --strict devtool
```

## Resources

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Repository Dispatch Events](https://docs.github.com/en/rest/repos/repos#create-a-repository-dispatch-event)
- [Creating a Homebrew Tap](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)

## Security Notes

- The `TAP_GITHUB_TOKEN` should be treated as sensitive information
- Never commit tokens to the repository
- Consider setting token expiration and rotating regularly
- The token only needs access to the tap repository
- Use GitHub's environment protection rules for additional security