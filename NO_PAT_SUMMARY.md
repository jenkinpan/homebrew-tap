# No Personal Access Token Required! 🎉

This Homebrew tap setup has been updated to use **SSH Deploy Keys** instead of Personal Access Tokens, making it more secure and easier to manage.

## What Changed?

### ❌ Before (PAT Method)
- Required creating a Personal Access Token with broad permissions
- Token had access to all your repositories
- Needed to manage token expiration
- Less secure due to wider scope

### ✅ Now (SSH Deploy Key Method)
- No Personal Access Token needed
- Uses SSH key pair for authentication
- Access limited to only the homebrew-tap repository
- No expiration concerns
- More secure with minimal permissions

## Quick Setup Summary

### 1. Generate SSH Key Pair
```bash
ssh-keygen -t ed25519 -C "homebrew-tap-deploy" -f ~/.ssh/homebrew_tap_deploy_key -N ""
```

### 2. Add Public Key to homebrew-tap
- Go to: https://github.com/jenkinpan/homebrew-tap/settings/keys
- Click "Add deploy key"
- Paste public key from: `cat ~/.ssh/homebrew_tap_deploy_key.pub`
- **✅ Check "Allow write access"**

### 3. Add Private Key to Project Repositories
Add the private key as `TAP_DEPLOY_KEY` secret to:
- https://github.com/jenkinpan/devtool-rs/settings/secrets/actions/new
- https://github.com/jenkinpan/pkg-checker-rs/settings/secrets/actions/new

**Paste entire content from:** `cat ~/.ssh/homebrew_tap_deploy_key`

## How It Works

```
Release Created → Build Binaries → Calculate SHA256
                                         ↓
                              [Use SSH Deploy Key]
                                         ↓
                              Clone homebrew-tap repo
                                         ↓
                              Update formula file
                                         ↓
                              Commit & Push changes
                                         ↓
                              Users can upgrade!
```

## Benefits

| Feature | SSH Deploy Key | Personal Access Token |
|---------|---------------|----------------------|
| **Scope** | Single repository only | All repositories |
| **Permissions** | Read/write to tap only | Broad access |
| **Expiration** | Never expires | Optional expiration |
| **Security** | ✅ More secure | ⚠️ Less secure |
| **Revocation** | Easy (per-repo) | Affects all uses |
| **Setup** | One-time SSH key | Token management |

## Updated Files

### Project Repositories
- `devtool-rs/.github/workflows/homebrew-release.yml` - Updated to use SSH
- `pkg-checker-rs/.github/workflows/homebrew-release.yml` - Updated to use SSH

### Documentation
- `QUICKSTART.md` - Updated with SSH deploy key instructions
- `SETUP.md` - Updated setup guide
- `README.md` - Updated to reflect new method
- `SSH_DEPLOY_KEY_SETUP.md` - New detailed SSH setup guide

### Secret Name Change
- **Old:** `TAP_GITHUB_TOKEN` (Personal Access Token)
- **New:** `TAP_DEPLOY_KEY` (SSH private key)

## Security Advantages

1. **Minimal Access:** Deploy key only has access to one repository
2. **No Expiration:** Won't break due to token expiration
3. **Easy Rotation:** Generate new key pair anytime
4. **Audit Trail:** GitHub tracks all deploy key usage
5. **Revoke Anytime:** Delete the deploy key to revoke access instantly

## Migration from PAT (If You Already Set It Up)

If you already set up with Personal Access Token:

1. Generate new SSH key pair (see above)
2. Add public key to homebrew-tap as deploy key
3. Update secrets in devtool-rs and pkg-checker-rs:
   - Delete `TAP_GITHUB_TOKEN` secret
   - Add `TAP_DEPLOY_KEY` secret with private key
4. Push the updated workflow files
5. Test with a new release

The old PAT can be safely deleted from GitHub settings.

## Complete Documentation

- **SSH_DEPLOY_KEY_SETUP.md** - Detailed setup instructions with troubleshooting
- **QUICKSTART.md** - Fast-track setup guide (5 minutes)
- **SETUP.md** - Comprehensive setup documentation
- **README.md** - User-facing installation guide

## Testing

After setup, test the automation:

```bash
cd ~/Documents/devtool-rs
git tag v0.x.x-test
git push origin v0.x.x-test
```

Watch GitHub Actions build and automatically update your tap! 🚀

## Troubleshooting

### "Permission denied (publickey)"
- Ensure deploy key is added with write access enabled
- Verify private key in secrets includes BEGIN/END lines

### "Updates were rejected"
- Check branch protection rules in homebrew-tap
- Ensure no conflicting commits

### Formula not updating
- Check GitHub Actions logs for errors
- Verify deploy key has write access
- Ensure private key is complete in secrets

## Summary

✅ **No Personal Access Token needed**  
✅ **More secure with scoped access**  
✅ **No expiration concerns**  
✅ **Easier to manage and revoke**  
✅ **Perfect for repository automation**

Your Homebrew tap will now automatically update using SSH authentication - more secure and no PAT required! 🎉