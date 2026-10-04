# Potluck CLI 0.1.5

`potluck login` now works like other command-line tools.

- On a Mac, or on Linux with a desktop, it opens your browser at the approval
  page with the code already filled in. Check that the code matches your
  terminal, then approve.
- The first time, you approve from an email link and can keep that browser
  signed in. After that, approving another terminal takes one click.
- Over SSH, in CI, on Linux without a display, or with `--no-browser`, it prints
  the same link to open on any device.
- `--json` and `--no-wait` output include `verificationUriComplete`, the link
  with the code filled in.

Sign-in uses the account service at trypotluck.ai, live since October 3, 2026.
Earlier CLI versions can sign in too; they print the link instead of opening it.

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
Expected CLI version: `0.1.5`.

## Compatibility and scope

macOS 15+ on Apple Silicon, and Linux x86-64 with glibc 2.35+. Node.js 20+
is required; Homebrew supplies it. Models download separately. This CLI-only
release keeps the native runtime from 0.1.3 and 0.1.4 byte for byte, including
its Developer ID signed and Apple-notarized Mac runtime. Existing settings,
downloaded weights and project model locks are preserved. The coding agent is
unchanged from 0.1.4.

The CLI and the desktop app run separate engines on one computer for now. While
the app is running, `potluck up` reports that another runtime is already
listening and most CLI commands cannot reach it. A shared runtime is planned
for the next desktop release. Household connections require a separately
installed mesh daemon. This release does not automatically enable sharing.
Windows, Intel Mac and Linux ARM64 archives are not included.
