# Zsh Dotfiles (Managed)

Version-controlled Zsh config with safe symlinks, backups, and optional Oh My Zsh.

## Repo layout
```
~/zsh/
  dotfiles/
    .zshrc
    .zprofile
  scripts/
    link_dotfiles.sh
    rollback_dotfiles.sh
    install_oh_my_zsh.sh
  backups/
    <timestamp>/
```

## Quick start
1) Link dotfiles (backs up any existing files automatically):
```bash
~/zsh/scripts/link_dotfiles.sh
```
- Backs up `~/.zshrc` and `~/.zprofile` into `~/zsh/backups/<timestamp>/`
- Creates symlinks from `~/zsh/dotfiles/*` to your home directory

2) Verify a clean shell startup:
```bash
zsh -i -c 'echo OK'
```
You should see `OK` without errors.

3) (Optional) Install Oh My Zsh:
```bash
~/zsh/scripts/install_oh_my_zsh.sh
```
- Guarded: skips if `~/.oh-my-zsh` already exists
- `.zshrc` will work with or without OMZ

## Making changes
- Edit files in `~/zsh/dotfiles/` (they are your source of truth)
- Test in a new shell: `zsh -i` (or `exec zsh` to reload)
- Commit your changes:
```bash
cd ~/zsh
git add dotfiles/.zshrc dotfiles/.zprofile
git commit -m "Update zsh config"
```

## Rollback
If something breaks, restore the latest backup snapshot:
```bash
~/zsh/scripts/rollback_dotfiles.sh
```
- Removes current symlinks and replaces them with the latest backed-up files
- Snapshots are stored under `~/zsh/backups/<timestamp>/`

## Notes
- Scripts are idempotent; safe to re-run.
- If your `.zshrc` references tools (kubectl, flux, fnm, etc.) not installed on a machine, either install them or comment out the relevant lines.
- To bring in dotfiles to a new machine: clone this repo to `~/zsh`, run `scripts/link_dotfiles.sh`, optionally run `scripts/install_oh_my_zsh.sh`.

## Common commands
```bash
# Link and back up existing files
~/zsh/scripts/link_dotfiles.sh

# Verify new shell loads cleanly
zsh -i -c 'echo OK'

# Install Oh My Zsh (optional)
~/zsh/scripts/install_oh_my_zsh.sh

# Roll back to last backup
~/zsh/scripts/rollback_dotfiles.sh
```

