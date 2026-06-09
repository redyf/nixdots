# sops-nix Setup

This repo uses `sops-nix` to keep secrets encrypted in Git. The encrypted file is committed, but the private age key stays only on the machine that needs to decrypt it.

Current desktop flow:

```text
hosts/<host>/secrets.yaml -> /var/lib/sops-nix/key.txt -> /run/secrets-for-users/users/<username>/password
```

## Safety Rules

- Commit public age recipients (`age1...`) only.
- Never commit private keys (`AGE-SECRET-KEY-1...`).
- Never commit `~/.config/sops/age/keys.txt` or `/var/lib/sops-nix/key.txt`.
- Back up the private key in a password manager or offline storage.
- Run `git status` before committing secrets-related changes.

The `.gitignore` already excludes common local key filenames such as `age-key*.txt`, `keys.txt`, `.sops.age`, and `*.age`.

## 1. Generate And Install An Age Key

Generate a key:

```bash
nix shell nixpkgs#age -c age-keygen -o ~/age-key.txt
grep "public key" ~/age-key.txt
```

Copy only the `age1...` public key.

Install the private key for both `sops-nix` and your user CLI:

```bash
sudo mkdir -p /var/lib/sops-nix
sudo install -m 600 -o root -g root ~/age-key.txt /var/lib/sops-nix/key.txt

mkdir -p ~/.config/sops/age
install -m 600 ~/age-key.txt ~/.config/sops/age/keys.txt
```

After backing it up, remove the temporary copy:

```bash
shred -u ~/age-key.txt
```

## 2. Configure `.sops.yaml`

Add the public key at the repository root:

```yaml
keys:
  - &desktop_user age1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
creation_rules:
  - path_regex: hosts/desktop/secrets\.yaml$
    key_groups:
      - age:
          - *desktop_user
```

Run `sops` commands from the repo root so this file is discovered automatically.

## 3. Create The Secret File

```bash
cd ~/opensource/nixdots
export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt
nix shell nixpkgs#sops -c sops hosts/desktop/secrets.yaml
```

Use this structure for the desktop user password:

```yaml
users:
    <username>:
        password: PLACEHOLDER
```

Save and verify that the file is encrypted on disk:

```bash
grep "ENC\[AES256_GCM" hosts/desktop/secrets.yaml
```

## 4. Add The User Password Hash

Generate a NixOS-compatible password hash:

```bash
nix shell nixpkgs#mkpasswd -c mkpasswd -m sha-512
```

Open the secret again and replace `PLACEHOLDER` with the full `$6$...` hash. Use single quotes because the hash contains `$`:

```yaml
users:
    <username>:
        password: '$6$rounds=656000$example...'
```

Confirm the hash was not saved in plaintext:

```bash
grep "\$6\$" hosts/desktop/secrets.yaml
```

This should print nothing.

## 5. Enable It In NixOS

The desktop host should enable SOPS and use the generated secret path:

```nix
myConfig = {
  users = {
    username = "<username>";
    hashedPasswordFile = config.sops.secrets."users/<username>/password".path;
  };

  system.sops.enable = true;
};
```

Validate the secret path:

```bash
nix eval .#nixosConfigurations.desktop.config.sops.secrets."users/<username>/password".path
```

Expected output:

```text
"/run/secrets-for-users/users/<username>/password"
```

Apply the system:

```bash
nh os switch
```

Before rebooting, test login in a TTY with `Ctrl+Alt+F2`. Return to the graphical session with `Ctrl+Alt+F1` or `Ctrl+Alt+F7`.

## Adding More Secrets

Edit the encrypted file:

```bash
cd ~/opensource/nixdots
export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt
nix shell nixpkgs#sops -c sops hosts/desktop/secrets.yaml
```

Add values under a clear path, for example:

```yaml
api_keys:
    github: ghp_example_only_do_not_use
```

Declare the secret in Nix:

```nix
sops.secrets."api_keys/github" = {
  owner = config.myConfig.users.username;
  mode = "0400";
};
```

Use `config.sops.secrets."api_keys/github".path` when a program needs the secret.

## Git Identity Secrets

The Git module reads identity data from SOPS-rendered config files instead of hardcoding names or emails in the repo.

Add these values to `hosts/<host>/secrets.yaml` with `sops`:

```yaml
git:
    personal:
        name: Your Personal Git Name
        email: your-personal-email@example.com
    work:
        name: Your Work Git Name
        email: your-work-email@example.com
```

`sops-nix` renders them at runtime:

```text
/run/secrets/rendered/git-personal
/run/secrets/rendered/git-work
```

The personal identity is included by default. The work identity is included for repositories under `~/work/*/`.

Use a generic work SSH key path on each host:

```text
~/.ssh/id_ed25519_work
```

That keeps host configs reusable without exposing employer-specific names in the repository.

After editing these secrets:

```bash
nh os switch
```

Then open a new shell and verify Git sees the expected identity:

```bash
git config --global user.name
git config --global user.email
git -C ~/work/<repo> config user.name
git -C ~/work/<repo> config user.email
```

If the work repository uses a separate SSH key, make sure the private key exists at `~/.ssh/id_ed25519_work` on that host.

## Adding Another Host

For another host, generate a new age key on that machine, install it the same way, and add a new creation rule:

```yaml
keys:
  - &desktop_user age1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  - &selene_user age1yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
creation_rules:
  - path_regex: hosts/desktop/secrets\.yaml$
    key_groups:
      - age:
          - *desktop_user
  - path_regex: hosts/selene/secrets\.yaml$
    key_groups:
      - age:
          - *selene_user
```

Then create `hosts/selene/secrets.yaml` with the same structure, enable `myConfig.system.sops.enable = true`, and point the user to `config.sops.secrets."users/selene/password".path`.

If you add the desktop key as a recipient for `selene`, you can edit `selene` secrets from the desktop, but a leaked desktop key would also decrypt those secrets.

## If You Lose The Age Key

The encrypted `secrets.yaml` file is stored in Git. The private age key is what lets you decrypt it.

If the machine dies but you have a backup of the private key, restore it to both locations and keep using the same `secrets.yaml`:

```bash
sudo install -m 600 -o root -g root /path/to/backup-key.txt /var/lib/sops-nix/key.txt
install -m 600 /path/to/backup-key.txt ~/.config/sops/age/keys.txt
```

If you lose the private key and have no backup, the old `secrets.yaml` cannot be decrypted. In that case, create a new age key, update `.sops.yaml`, and recreate the secret values manually.

For the current setup, that means recreating:

- The user password hash under `users/<username>/password`.
- The personal Git name/email under `git.personal`.
- The work Git name/email under `git.work`.

This is manageable because those values can be regenerated or typed again. It becomes more serious if you later store API tokens or one-time credentials in SOPS, so keep those backed up in a password manager too.

## Troubleshooting

| Symptom | Fix |
|---|---|
| `config file not found, or has no creation rules` | Run from the repo root and check `.sops.yaml` `path_regex`. |
| `no key could decrypt the data` | Check `SOPS_AGE_KEY_FILE` and confirm the matching public key is in `.sops.yaml`. |
| Boot cannot decrypt secrets | Confirm `/var/lib/sops-nix/key.txt` exists and is owned by `root:root` with mode `600`. |
| `users/<username>/password` is missing | Check `myConfig.system.sops.enable`, `myConfig.users.username`, and the YAML path. |
| Login fails after switch | Regenerate the hash with `mkpasswd -m sha-512` and check `journalctl -u sops-install-secrets-for-users`. |
