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
