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

# Potluck CLI 0.1.4

This update gives the coding agent better file context during repairs and adds
literal-code writes with stricter whole-file overwrite checks.

- File reads identify their path. Edits and failed matches return bounded current
  code context so subsequent repairs can use the actual file contents.
- Repository maps include Python and JavaScript/TypeScript declaration hints.
- Repair feedback keeps the original request nearby within the existing context
  budget, helping the model retain requirements across multiple edits.
- Complete file writes can carry literal code instead of an escaped JSON string.
  Matching fences, completed streams, workspace boundaries and approval still apply.
- Truncated reads and unreadable existing files cannot authorize whole-file
  replacement.

## Measured development result

With the same pinned Qwen2.5-Coder 14B Q4_K_M model and unchanged task limits,
the original three-task coding evaluation improved from **1/3 to 2/3 passed**
in both repetitions. Retry scheduling repairs now pass the visible and independent
checks. Across five tasks repeated twice, successful attempts improved from
**2/10 to 4/10** compared with 0.1.3.

This is a small development suite used during iteration, not a broad or sealed
coding benchmark. CSV, configuration and routing tasks still fail. The selected
model trials did not use the new literal-write format; the score gain cannot be
attributed to that format. No speedup or multi-machine quality improvement is
claimed. Review generated changes even when configured checks pass.

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
Expected CLI version: `0.1.4`.

## Compatibility and scope

macOS 15+ on Apple Silicon, and Linux x86-64 with glibc 2.35+. Node.js 20+
is required; Homebrew supplies it. Models download separately. This CLI-only
release preserves the native runtime distributed in 0.1.3, including its
Developer ID signed and Apple-notarized Mac runtime. Existing settings,
downloaded weights and project model locks are preserved.

Managed split-model execution remains under separate development and is not
included. Browser device login awaits the account-service rollout. Household
connections require a separately installed mesh daemon and an existing signed-in
account. After a mesh disconnect, restoring connectivity may require restarting
the affected peer's mesh daemon. This release does not automatically enable
sharing. Windows, Intel Mac and Linux ARM64 archives are not included.

# Potluck CLI 0.1.3

This update improves recovery when a coding model emits malformed actions or
gets stuck, and makes one-shot exit codes reflect unfinished work.

- Validate tool names and arguments before executing them. Recover narrow JSON
  and Markdown framing mistakes without inventing missing arguments.
- Wait for a completed response before running a tool. Interrupted streams do
  not execute pending edits.
- Detect repeated unchanged reads, failed edits, and no-op writes, including
  failed-edit loops separated by reads. Stop bounded loops with a clear reason.
- Keep test failures in later tool feedback while repairing multiple files.
  Check otherwise unverified completion and stop after four consecutive failed
  checks. Incomplete one-shot runs exit with status 1.
- Correct file-scoped searches that could incorrectly return no matches.
- Respect cancellation during final verification.

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
Expected CLI version: `0.1.3`.

## Compatibility and scope

macOS 15+ on Apple Silicon, and Linux x86-64 with glibc 2.35+. Node.js 20+
is required; Homebrew supplies it. Models download separately. This CLI-only
release bundles the exact native runtime bytes from 0.1.2, including its
Developer ID signed and Apple-notarized Mac runtime. Existing settings,
downloaded weights and project model locks are preserved.

The changes improve protocol handling and failure reporting, not model weights.
They do not establish a coding-quality or speed improvement. Review generated
changes even when the configured checks pass. Managed split-model execution is
still under separate development and is not included in this release.

Browser device login still awaits the account-service rollout. Household
connections require a separately installed mesh daemon and an existing signed-in
account. After a mesh disconnect, restoring connectivity may require restarting
the affected peer's mesh daemon. This release does not automatically enable
sharing. Windows, Intel Mac and Linux ARM64 archives are not included.

---

# Potluck CLI 0.1.1

Project model locks and more reliable household inference, with native downloads for Apple Silicon Mac and Linux x86-64.

- Pin exact model weights per project with `potluck models pin` and `potluck models sync`. Runtime upgrades preserve the lock; mismatched weights are rejected.
- Guided local setup, plain `potluck run` inference and piped input, project-aware diagnostics, live status, Aider integration, explicit saved agent sessions, and contribution schedules/resource limits.
- Household requests can retry another eligible computer before output, preserving the requested model and exact pin. Interrupted responses return an error after output begins, without silent replay.
- Quiet-stream reachability checks detect disconnected or frozen workers sooner while preserving slow, healthy inference. Real household tests measured roughly eight seconds after injected failures; this is a test result, not a guaranteed latency.
- Linux mesh socket discovery and model identity validation improved.

## Install or upgrade

```sh
brew install newtorob/potluck/potluck
```

For an existing installation:

```sh
brew update
brew upgrade potluck
potluck --version
```

Standalone downloads and checksums are linked in the [installation guide](https://github.com/newtorob/homebrew-potluck#downloads).

## Supported environments

macOS 15+ on Apple Silicon; Linux x86-64 with glibc 2.35+. Node.js 20+ is required and supplied by Homebrew. Models download separately. The Mac runtime is Developer ID signed and Apple notarized.

Browser device login is awaiting the account-service rollout. Household connections require a separately installed mesh daemon and an existing signed-in account. This release does not automatically enable sharing. Windows, Intel Mac and Linux ARM64 downloads are not included.

## Known household reconnect limitation

After a mesh disconnect, restoring household connectivity can require restarting
the mesh daemon on the affected peer. This was observed during release validation
and is tracked separately from the CLI runtime. Interrupted output is reported
as an error; the CLI does not silently substitute another model.
