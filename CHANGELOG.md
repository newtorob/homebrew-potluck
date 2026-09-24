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
