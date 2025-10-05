# Homebrew Tap for jenkinpan

This is a custom Homebrew tap for installing my Rust CLI tools.

## Installation

First, tap this repository:

```bash
brew tap jenkinpan/tap https://github.com/jenkinpan/homebrew-tap
```

## Available Formulae

### devtool

A CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages.

**Install:**
```bash
brew install jenkinpan/tap/devtool
```

**Repository:** [devtool-rs](https://github.com/jenkinpan/devtool-rs)

### pkg-checker

A Rust tool for checking and updating globally installed Cargo packages with interactive mode and smart prerelease detection.

**Install:**
```bash
brew install jenkinpan/tap/pkg-checker
```

**Repository:** [pkg-checker-rs](https://github.com/jenkinpan/pkg-checker-rs)

## Automatic Updates

This tap is automatically updated when new releases are published to the respective GitHub repositories. The formulae are updated via GitHub Actions workflows using SSH deploy keys.

## How It Works

1. When a new release is created in `devtool-rs` or `pkg-checker-rs`, their CI/CD pipelines build binaries and calculate checksums
2. The workflow uses an SSH deploy key to clone this tap repository
3. The formula is automatically updated with the new version and checksums
4. Changes are committed and pushed back to the tap repository

## Setup

To enable automatic updates, you need to configure SSH deploy keys. See [SSH_DEPLOY_KEY_SETUP.md](./SSH_DEPLOY_KEY_SETUP.md) for detailed instructions.

**Quick setup:**
1. Generate SSH key pair
2. Add public key as deploy key to this repository (with write access)
3. Add private key as secret to `devtool-rs` and `pkg-checker-rs` repositories

## Development

To add a new formula to this tap:

1. Create a new `.rb` file in the `Formula/` directory
2. Follow the Homebrew formula guidelines
3. Create a corresponding GitHub Actions workflow in `.github/workflows/` for automatic updates

## License

This tap follows the licenses of individual formulae:
- **devtool**: MIT OR Apache-2.0
- **pkg-checker**: MIT