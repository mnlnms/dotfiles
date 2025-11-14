Future Dotfile - Repo
```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mnlnms/dotfiles/main/.startup.sh)"
````

First 'Automatic Deployment' did not work oob.

- Installation from xcode-select via softwareupdate worked, but had problems
- Terminal needs 'Full Disk Access', otherwise Determinate Nix won't install
- Terminal did not source correctly after installation from nix
