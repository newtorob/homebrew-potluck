# Potluck CLI 0.1.6

`potluck login` now works in one step, the way `tailscale login` does.

- If the Potluck engine is not running, `potluck login` starts it in the
  background, opens your browser to approve this terminal, and finishes when
  you approve. `potluck down` stops the engine.
- `logout`, `whoami`, `household` and `connect` also start the engine when
  needed, instead of asking you to run `potluck up` first.
- On a computer running the Potluck desktop app 0.1.7 or later, the CLI uses
  the app's engine and sign-in, so there is nothing to start and no second
  login.
- If an older desktop app is holding the engine's port, the CLI now says so
  and asks you to update or quit the app.

## Install or upgrade

```sh
brew install newtorob/potluck/potluck
```

Existing installations:

```sh
brew update
brew upgrade potluck
potluck --version
```

Standalone archives and checksums: [downloads](https://github.com/newtorob/homebrew-potluck#downloads).
Expected CLI version: `0.1.6`.

## Compatibility and scope

macOS 15+ on Apple Silicon, and Linux x86-64 with glibc 2.35+. Node.js 20+
is required; Homebrew supplies it. This CLI-only release keeps the native
runtime from 0.1.3 to 0.1.5 byte for byte, including its Developer ID signed
and Apple-notarized Mac runtime. Existing settings, downloaded weights and
project model locks are preserved. The coding agent is unchanged.

Household connections require a separately installed mesh daemon. This
release does not automatically enable sharing. Windows, Intel Mac and Linux
ARM64 archives are not included.
