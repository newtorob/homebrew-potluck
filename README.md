# Potluck CLI 0.1.0

Set up your local AI runtime, manage models, inspect connections, and use a
terminal coding agent powered by Potluck.

## Downloads

| Platform | Archive | Checksum |
| --- | --- | --- |
| macOS 15+, Apple Silicon | [Download](https://releases.trypotluck.ai/cli/0.1.0/potluck-cli-0.1.0-darwin-arm64.tar.gz) | [SHA-256](https://releases.trypotluck.ai/cli/0.1.0/potluck-cli-0.1.0-darwin-arm64.tar.gz.sha256) |
| Linux x86-64, glibc 2.35+ | [Download](https://releases.trypotluck.ai/cli/0.1.0/potluck-cli-0.1.0-linux-x64.tar.gz) | [SHA-256](https://releases.trypotluck.ai/cli/0.1.0/potluck-cli-0.1.0-linux-x64.tar.gz.sha256) |

The macOS runtime is signed with Developer ID and notarized by Apple.
This repository contains the Homebrew formula and installation documentation.

## Install

Supported downloads: macOS 15 or newer on Apple Silicon, and Linux x86-64 with
glibc 2.35 or newer (such as Ubuntu 22.04+). Node.js 20 or newer is required.
The archive includes the Python runtime; no separate Python
installation or desktop app is required. Models are downloaded separately.

Homebrew installs the CLI and Node:

```sh
brew install newtorob/potluck/potluck
```

For a standalone archive, verify its SHA-256 using the adjacent `.sha256` file,
extract it, and run this from the extracted directory:

```sh
node install.mjs
export PATH="$HOME/.local/bin:$PATH"
potluck --version
```

Use `node install.mjs --prefix /absolute/path` for a custom installation.
Install as your own user, without sudo. Add the installation's `bin` directory
to your shell's PATH for future terminals.

## First local run

```sh
potluck setup --no-input
potluck models list
potluck models install <model-id>
potluck models progress <model-id>
```

Choose a model from the list that fits your machine. Once its download finishes:

```sh
potluck models load <model-id>
potluck gateway enable
potluck --scope local -p "Say hello"
potluck doctor --scope local
```

`potluck gateway enable` enables authenticated local API access for the coding
agent and other tools. Setup without explicit options does not enable sharing.
Use `potluck down` to stop an engine started by the CLI. `potluck --help` lists
commands, and `potluck status --json` reports runtime and model readiness.

## Background runtime

For Homebrew installations:

```sh
brew services start potluck
brew services stop potluck
```

For standalone installations:

```sh
potluck service install
potluck service status
potluck service uninstall
```

Stop a CLI-owned engine with `potluck down` before switching to a service.
Services start at user login; Linux requires a working systemd user session.
Uninstalling a service retains your accounts, models, and settings.

## Scope of this release

Local runtime, model management, diagnostics, gateway controls, and user services
are available. Browser device login is awaiting the account-service rollout.
Household connection requires the separately installed Potluck mesh daemon and
a signed-in account. This download does not install that daemon or automatically
enable network sharing. Windows, Intel Mac, and Linux ARM64 archives are not
included in this release.

## Updates and support

Homebrew: `brew update && brew upgrade potluck`.
Standalone: install a newer archive, then rerun `potluck service install` if you
use its service. Previous versions are retained under the installation prefix.
Stop and uninstall services before removing binaries. Keep `~/.potluck` to
preserve your data.

Downloads and installation help: https://github.com/newtorob/homebrew-potluck
Product: https://trypotluck.ai
