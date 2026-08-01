dotfiles
========

Another dotfiles repo — managed with [chezmoi](https://www.chezmoi.io/) in
**symlink mode**.

## How it works

- Files in this repo use chezmoi's naming convention: `dot_bashrc` becomes
  `~/.bashrc`, `dot_git_template/` becomes `~/.git_template/`, and so on.
- chezmoi runs in symlink mode with this repo as its source directory
  (`~/.config/chezmoi/chezmoi.toml`):

  ```toml
  sourceDir = "~/workspace/dotfiles"
  mode = "symlink"
  ```

  `chezmoi apply` therefore creates symlinks in `$HOME` that point into this
  repo, instead of copying file contents. Editing a `dot_` file here is live
  immediately — no `chezmoi apply` needed after edits, only after adding or
  renaming files.
- `.chezmoiignore` lists files that live in the repo but must not be applied
  to `$HOME` (`README.md`, helper scripts, app configs handled elsewhere).

## Migrating from the old manual symlink setup

The previous setup symlinked files by hand (e.g. `ln -s ~/workspace/dotfiles/bashrc ~/.bashrc`).
To migrate a machine:

1. **Install chezmoi**

   ```sh
   brew install chezmoi
   ```

2. **Point chezmoi at this repo in symlink mode**

   Create `~/.config/chezmoi/chezmoi.toml`:

   ```toml
   sourceDir = "~/workspace/dotfiles"
   mode = "symlink"
   ```

   (Clone the repo to `~/workspace/dotfiles` first if it isn't there yet.
   The usual `chezmoi init` flow copies the repo to
   `~/.local/share/chezmoi`; setting `sourceDir` explicitly keeps the
   existing checkout as the single working copy.)

3. **Pull the chezmoi-migrated state**

   ```sh
   cd ~/workspace/dotfiles && git pull
   ```

   Files were renamed to the chezmoi convention (`bashrc` → `dot_bashrc`),
   so any old manual symlinks now dangle — they point at paths that no
   longer exist.

4. **Remove the old manual symlinks**

   Delete every symlink in `$HOME` that points into this repo. To find them:

   ```sh
   find ~ -maxdepth 1 -type l -lname '*workspace/dotfiles*' -print
   ```

   Review the list, then append `-delete` (or remove them one by one with
   `rm`). Don't forget non-top-level ones like `~/.git_template` if you
   linked directories, and check `~/.config/` too.

5. **Let chezmoi create the new symlinks**

   ```sh
   chezmoi apply -v
   ```

   Verify: `ls -la ~/.bashrc` should show a symlink to
   `~/workspace/dotfiles/dot_bashrc`.

## Day-to-day usage

- **Edit a managed file**: edit the `dot_` file in this repo (or the target in
  `$HOME` — it's the same file through the symlink). Changes are live; commit
  when done.
- **Add a new dotfile**:

  ```sh
  chezmoi add ~/.some_config
  ```

  This moves the content into the repo as `dot_some_config` and replaces the
  original with a symlink. Then commit.
- **Stop managing a file**: `chezmoi forget ~/.some_config` (keeps the target),
  then remove it from the repo.
- **Check what would change**: `chezmoi status` / `chezmoi diff`.
- **Keep repo-only files out of `$HOME`**: add them to `.chezmoiignore`.
