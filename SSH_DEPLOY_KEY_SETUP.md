# SSH Deploy Key Setup Guide

This guide explains how to set up SSH Deploy Keys instead of using a Personal Access Token for automatic Homebrew tap updates.

## Why SSH Deploy Keys?

**Advantages over Personal Access Token:**
- ✅ No need for Personal Access Token
- ✅ More secure - scoped to a single repository
- ✅ No expiration date concerns
- ✅ Easier to revoke and rotate
- ✅ Read/write access only to the tap repository

## Setup Instructions

### Step 1: Generate SSH Key Pair

On your local machine, generate a new SSH key pair specifically for this deployment:

```bash
# Generate a new SSH key (no passphrase for automation)
ssh-keygen -t ed25519 -C "devtool-homebrew-tap-deploy" -f ~/.ssh/homebrew_tap_deploy_key -N ""

# This creates two files:
# - ~/.ssh/homebrew_tap_deploy_key (private key)
# - ~/.ssh/homebrew_tap_deploy_key.pub (public key)
```

### Step 2: Add Public Key as Deploy Key to homebrew-tap Repository

1. Display your public key:
   ```bash
   cat ~/.ssh/homebrew_tap_deploy_key.pub
   ```

2. Go to your tap repository on GitHub:
   ```
   https://github.com/jenkinpan/homebrew-tap/settings/keys
   ```

3. Click **"Add deploy key"**

4. Fill in the form:
   - **Title**: `GitHub Actions Deploy Key`
   - **Key**: Paste the contents of `homebrew_tap_deploy_key.pub`
   - **Allow write access**: ✅ **CHECK THIS BOX** (required for pushing updates)

5. Click **"Add key"**

### Step 3: Add Private Key to devtool-rs Repository

1. Display your private key:
   ```bash
   cat ~/.ssh/homebrew_tap_deploy_key
   ```
   
   **Important**: Copy the ENTIRE content including:
   ```
   -----BEGIN OPENSSH PRIVATE KEY-----
   ... (all content) ...
   -----END OPENSSH PRIVATE KEY-----
   ```

2. Go to devtool-rs repository secrets:
   ```
   https://github.com/jenkinpan/devtool-rs/settings/secrets/actions/new
   ```

3. Add the secret:
   - **Name**: `TAP_DEPLOY_KEY`
   - **Secret**: Paste the entire private key content
   - Click **"Add secret"**

### Step 4: Add Private Key to pkg-checker-rs Repository

Repeat the same process for pkg-checker-rs:

1. Go to pkg-checker-rs repository secrets:
   ```
   https://github.com/jenkinpan/pkg-checker-rs/settings/secrets/actions/new
   ```

2. Add the secret:
   - **Name**: `TAP_DEPLOY_KEY`
   - **Secret**: Paste the same private key content
   - Click **"Add secret"**

### Step 5: Secure Your Private Key

After adding the key to GitHub secrets, you can optionally remove it from your local machine:

```bash
# Optional: Remove the private key from your machine
# (It's now stored securely in GitHub Secrets)
rm ~/.ssh/homebrew_tap_deploy_key
rm ~/.ssh/homebrew_tap_deploy_key.pub
```

**Or keep it backed up securely** in case you need to re-add it later.

## How It Works

When a release is created:

1. The release workflow runs in devtool-rs or pkg-checker-rs
2. It uses the `TAP_DEPLOY_KEY` to authenticate with GitHub
3. It clones the homebrew-tap repository
4. Updates the formula file with new version and checksums
5. Commits and pushes the changes back to homebrew-tap

All of this happens without needing a Personal Access Token!

## Testing the Setup

After setting up the keys, test the workflow:

```bash
# In devtool-rs or pkg-checker-rs
git tag v0.x.x-test
git push origin v0.x.x-test
```

Monitor the GitHub Actions to ensure:
1. Binaries are built successfully
2. The tap repository is cloned
3. The formula is updated
4. Changes are committed and pushed

If successful, you'll see a new commit in your homebrew-tap repository!

## Troubleshooting

### Error: "Permission denied (publickey)"

**Cause**: The deploy key wasn't added correctly or write access wasn't granted.

**Solution**:
1. Verify the deploy key is added to homebrew-tap repository
2. Ensure "Allow write access" is checked
3. Verify the private key in secrets is complete (includes BEGIN/END lines)

### Error: "Host key verification failed"

**Cause**: SSH host key verification issue.

**Solution**: The workflow should handle this automatically. If it persists, the checkout action will handle it.

### Error: "Updates were rejected"

**Cause**: Branch protection rules or merge conflicts.

**Solution**:
1. Check homebrew-tap repository settings → Branches
2. Ensure branch protection doesn't block the deploy key
3. Check for any uncommitted changes in the repository

### Formula not updating

**Check**:
1. Verify the workflow completed successfully in Actions tab
2. Check the homebrew-tap repository for recent commits
3. Review the workflow logs for any errors

## Security Best Practices

1. **One Key Per Use Case**: Create separate deploy keys for different purposes
2. **Minimal Permissions**: Deploy keys only have access to one repository
3. **Rotate Regularly**: Regenerate and update keys periodically
4. **Monitor Usage**: Check GitHub's audit log for unexpected access
5. **Revoke When Needed**: Remove deploy keys that are no longer needed

## Revoking Access

If you need to revoke access:

1. Go to: `https://github.com/jenkinpan/homebrew-tap/settings/keys`
2. Find the deploy key
3. Click **"Delete"**
4. Update secrets in devtool-rs and pkg-checker-rs with a new key

## Comparison: Deploy Key vs Personal Access Token

| Feature | Deploy Key | Personal Access Token |
|---------|------------|----------------------|
| Scope | Single repository | Multiple repositories |
| Write Access | Per-repository | Account-wide |
| Expiration | Never | Optional (recommended) |
| Rotation | Manual | Manual |
| Revocation | Per-repository | Account-wide |
| Setup Complexity | Slightly higher | Simpler |
| Security | More secure (scoped) | Less secure (broader) |

## Summary

✅ **Benefits of this approach:**
- No Personal Access Token needed
- More secure with limited scope
- No expiration concerns
- Easy to revoke and rotate
- Perfect for repository-to-repository automation

🔐 **Security note:**
The private key allows write access to your homebrew-tap repository. Treat it like a password and never commit it to your code!

## Next Steps

After completing this setup:

1. Push the updated workflows to your project repositories
2. Create a test release to verify everything works
3. Monitor the first few automatic updates
4. Update your documentation to reflect the new setup

Your Homebrew tap will now update automatically without needing a Personal Access Token! 🚀