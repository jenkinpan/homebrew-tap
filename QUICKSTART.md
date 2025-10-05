# Homebrew Tap Quick Start Guide

This guide will help you quickly set up and deploy your Homebrew tap for `devtool` and `pkg-checker`.

## 🚀 Quick Setup (5 minutes)

### 1. Push the tap repository to GitHub

```bash
cd ~/Documents/homebrew-tap
git branch -M main
git remote add origin https://github.com/jenkinpan/homebrew-tap.git
git push -u origin main
```

**Important**: The repository MUST be public for Homebrew to access it.

### 2. Generate SSH Deploy Key

Generate a new SSH key pair for deployment:

```bash
ssh-keygen -t ed25519 -C "homebrew-tap-deploy" -f ~/.ssh/homebrew_tap_deploy_key -N ""
```

This creates two files:
- `~/.ssh/homebrew_tap_deploy_key` (private key)
- `~/.ssh/homebrew_tap_deploy_key.pub` (public key)

### 3. Add Public Key to homebrew-tap Repository

1. Display your public key:
   ```bash
   cat ~/.ssh/homebrew_tap_deploy_key.pub
   ```

2. Go to: https://github.com/jenkinpan/homebrew-tap/settings/keys

3. Click "Add deploy key"

4. Fill in:
   - **Title**: `GitHub Actions Deploy Key`
   - **Key**: Paste the public key content
   - ✅ **Check "Allow write access"** (important!)

5. Click "Add key"

### 4. Add Private Key to both project repositories

**Important**: Copy the ENTIRE private key including the BEGIN/END lines:

```bash
cat ~/.ssh/homebrew_tap_deploy_key
```

#### For devtool-rs:
```
1. Visit: https://github.com/jenkinpan/devtool-rs/settings/secrets/actions/new
2. Name: TAP_DEPLOY_KEY
3. Secret: [paste the entire private key]
4. Click "Add secret"
```

#### For pkg-checker-rs:
```
1. Visit: https://github.com/jenkinpan/pkg-checker-rs/settings/secrets/actions/new
2. Name: TAP_DEPLOY_KEY
3. Secret: [paste the same private key]
4. Click "Add secret"
```

### 5. Push the new workflows to project repositories

```bash
# Push devtool-rs workflow
cd ~/Documents/devtool-rs
git push origin main

# Push pkg-checker-rs workflow
cd ~/Documents/pkg-checker-rs
git push origin master
```

### 6. Test the setup

Install the tap locally:

```bash
brew tap jenkinpan/tap
brew install jenkinpan/tap/devtool
brew install jenkinpan/tap/pkg-checker
```

## 📦 How to Release a New Version

When you want to release a new version:

### For devtool-rs:

```bash
cd ~/Documents/devtool-rs
git tag v0.4.2  # Increment version appropriately
git push origin v0.4.2
```

### For pkg-checker-rs:

```bash
cd ~/Documents/pkg-checker-rs
git tag v0.7.2  # Increment version appropriately
git push origin v0.7.2
```

### What happens automatically:

1. ✨ **GitHub Actions starts** building binaries for all platforms
2. 📦 **Binaries are created** for:
   - macOS ARM64 (Apple Silicon)
   - macOS x86_64 (Intel)
   - Linux ARM64
   - Linux x86_64
3. 🔐 **SHA256 checksums** are calculated automatically
4. 📤 **GitHub Release** is created with all binaries
5. 🔔 **Tap repository** is notified with version and checksums
6. 🔄 **Formula is updated** automatically in homebrew-tap
7. ✅ **Users can upgrade** with `brew upgrade`

## 🎯 Usage for End Users

Once your tap is set up, users can install your tools with:

```bash
# First time setup
brew tap jenkinpan/tap

# Install tools
brew install devtool
brew install pkg-checker

# Upgrade when new versions are available
brew upgrade devtool
brew upgrade pkg-checker

# Uninstall if needed
brew uninstall devtool
brew uninstall pkg-checker
```

## 🔍 Verify Everything Works

After setting up, you can verify:

### Check the tap is accessible:
```bash
brew tap | grep jenkinpan
```

### Check the formulae are available:
```bash
brew info jenkinpan/tap/devtool
brew info jenkinpan/tap/pkg-checker
```

### Check installed versions:
```bash
devtool --version
pkg-checker --version
```

## 🐛 Troubleshooting

### "Formula not found"
- Ensure the tap repository is **public**
- Run `brew update` and try again
- Check formula files are in `Formula/` directory (capital F)

### "Failed to download resource"
- Verify the release exists on GitHub
- Check the version number matches in the formula
- Ensure the binary tarballs were uploaded to the release

### Workflow not triggering
- Verify `TAP_DEPLOY_KEY` secret is set in both repositories
- Check the deploy key is added to homebrew-tap with write access
- Ensure the private key includes BEGIN/END lines

### SHA256 checksum mismatch
- Don't manually edit checksums - they're auto-calculated
- If error persists, re-run the release workflow
- Check that the tarball wasn't corrupted during upload

## 📚 Project Structure

```
homebrew-tap/
├── Formula/
│   ├── devtool.rb           # Homebrew formula for devtool
│   └── pkg-checker.rb       # Homebrew formula for pkg-checker
├── .github/
│   └── workflows/
│       ├── update-devtool.yml       # Auto-update workflow for devtool
│       └── update-pkg-checker.yml   # Auto-update workflow for pkg-checker
├── README.md                # User-facing documentation
├── SETUP.md                 # Detailed setup instructions
├── QUICKSTART.md            # This file
└── .gitignore              # Git ignore rules

devtool-rs/
└── .github/
    └── workflows/
        └── homebrew-release.yml     # Build & trigger tap update

pkg-checker-rs/
└── .github/
    └── workflows/
        └── homebrew-release.yml     # Build & trigger tap update
```

## 🔄 Update Flow Diagram

```
Developer                    GitHub Actions                   Homebrew Tap
    |                              |                               |
    |--[git tag v0.x.x]----------->|                               |
    |                              |                               |
    |                         [Build Binaries]                     |
    |                              |                               |
    |                    [Calculate SHA256 Checksums]              |
    |                              |                               |
    |                      [Create GitHub Release]                 |
    |                              |                               |
    |                              |--[SSH: Clone tap repo]------->|
    |                              |                               |
    |                              |--[Update Formula]------------>|
    |                              |                               |
    |                              |--[Git Commit & Push]--------->|
    |                              |                               |
    |<-[Users can now upgrade]-------------------------------------'
```

## ✅ Checklist

Use this checklist to ensure everything is set up correctly:

- [ ] Homebrew tap repository created on GitHub (public)
- [ ] Tap repository pushed to GitHub
- [ ] SSH key pair generated
- [ ] Public key added as deploy key to homebrew-tap (with write access)
- [ ] `TAP_DEPLOY_KEY` secret added to devtool-rs repository
- [ ] `TAP_DEPLOY_KEY` secret added to pkg-checker-rs repository
- [ ] Homebrew release workflows pushed to both project repositories
- [ ] Tap installed locally: `brew tap jenkinpan/tap`
- [ ] Tools installed successfully
- [ ] Tools run correctly: `devtool --version` and `pkg-checker --version`
- [ ] Test release created to verify automatic updates work

## 🎉 You're Done!

Your Homebrew tap is now set up and ready to automatically update whenever you release new versions of your tools!

For more detailed information, see:
- [SETUP.md](./SETUP.md) - Comprehensive setup guide
- [README.md](./README.md) - User documentation
- [Homebrew Tap Documentation](https://docs.brew.sh/Taps)

## 📞 Need Help?

If you encounter issues:
1. Check the [Troubleshooting](#-troubleshooting) section above
2. Review the GitHub Actions logs for your workflows
3. Consult the [SETUP.md](./SETUP.md) for detailed instructions