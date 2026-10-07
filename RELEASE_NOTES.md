# Potluck CLI 0.1.8

Share a machine with a trusted circle, and send a prompt to one.

- `potluck contribute share circles` lets people in a trusted circle with you
  send requests to this machine. A machine shared this way is never offered
  open pool work. `potluck contribute share mine` returns it to your own
  machines only, which is the default.
- `potluck contribute status` now says who the machine is shared with.
- `potluck run --scope circle` sends one prompt to a machine in one of your
  trusted circles. Add `--circle <name>` when you have more than one circle,
  and pass a `--model` the circle is offering. The desktop app's chat header
  lists those models. The machine that answers sees the prompt.
- The engine recovers by itself when sharing is switched on before you sign
  in, and announces a model you load after it has connected.
- Coding agent sessions, batch jobs and projects with a model lock still run
  on your own machines only.

Circles are created and managed in the desktop app (0.1.9 or later). Trusted
circle sharing is new: it has been tested end to end on our own machines and
has not had wide use yet.

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

When the CLI uses the desktop app's engine, update the desktop app to 0.1.9 as
well. Restart a running engine after upgrading (`potluck down`, then any
command).

Standalone archives and checksums: [downloads](https://github.com/newtorob/homebrew-potluck#downloads).
