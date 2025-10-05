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

## Step 3: Generate SSH Deploy Key

Generate a new SSH key pair specifically for deployment:

```bash
ssh-keygen -t ed25519 -C "homebrew-tap-deploy" -f ~/.ssh/homebrew_tap_deploy_key -N ""
```

This creates two files:
- `~/.ssh/homebrew_tap_deploy_key` (private key)
- `~/.ssh/homebrew_tap_deploy_key.pub` (public key)

## Step 4: Add Public Key to homebrew-tap Repository

1. Display your public key:
   ```bash
   cat ~/.ssh/homebrew_tap_deploy_key.pub
   ```

2. Go to the `homebrew-tap` repository on GitHub
3. Navigate to Settings → Deploy keys
4. Click "Add deploy key"
5. Fill in:
   - **Title**: `GitHub Actions Deploy Key`
   - **Key**: Paste the public key content
   - **Allow write access**: ✅ **CHECK THIS BOX** (required for pushing updates)
6. Click "Add key"

## Step 5: Add Private Key to devtool-rs Repository

**Important**: Copy the ENTIRE private key including the BEGIN/END lines:

```bash
cat ~/.ssh/homebrew_tap_deploy_key
```

1. Go to the `devtool-rs` repository on GitHub
2. Navigate to Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Name: `TAP_DEPLOY_KEY`
5. Value: Paste the entire private key content (including `-----BEGIN OPENSSH PRIVATE KEY-----` and `-----END OPENSSH PRIVATE KEY-----`)
6. Click "Add secret"

## Step 6: Add Private Key to pkg-checker-rs Repository

Repeat the same process for `pkg-checker-rs`:

1. Go to the `pkg-checker-rs` repository on GitHub
2. Navigate to Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Name: `TAP_DEPLOY_KEY`
5. Value: Paste the same private key content
6. Click "Add secret"

## Step 7: Secure Your Private Key (Optional)

After adding the key to GitHub secrets, you can optionally remove it from your local machine:

```bash
# Optional: Remove the private key from your machine
# (It's now stored securely in GitHub Secrets)
rm ~/.ssh/homebrew_tap_deploy_key
rm ~/.ssh/homebrew_tap_deploy_key.pub
```

Or keep it backed up securely in case you need to re-add it later.

## Step 8: Test the Setup

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

## Step 9: Install and Test Locally

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
3. **Trigger Step**: Uses SSH deploy key to clone and update `homebrew-tap` repository
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
- Check that `TAP_DEPLOY_KEY` secret is correctly set in both project repositories
- Verify the deploy key is added to homebrew-tap with write access enabled
- Ensure the private key includes the BEGIN/END lines
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

- The `TAP_DEPLOY_KEY` (private key) should be treated as sensitive information
- Never commit private keys to the repository
- Deploy keys are scoped to a single repository (more secure than PAT)
- The deploy key only has access to the tap repository
- Deploy keys don't expire, but can be easily revoked and rotated
- Use GitHub's environment protection rules for additional security

## Benefits of SSH Deploy Key over Personal Access Token

- ✅ No need for Personal Access Token
- ✅ More secure - scoped to a single repository
- ✅ No expiration date concerns
- ✅ Easier to revoke and rotate
- ✅ Read/write access only to the tap repository

See [SSH_DEPLOY_KEY_SETUP.md](./SSH_DEPLOY_KEY_SETUP.md) for detailed information.