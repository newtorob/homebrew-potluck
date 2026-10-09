# Potluck CLI 0.1.9

Invite people to a trusted circle and join one from the terminal. Also closes
a hole in which machines may send requests to yours.

- `potluck circle create "<name>"` makes a circle. `potluck circle invite
  "<circle>"` prints a code and a link that work once and expire after seven
  days. Send it to one person you trust.
- `potluck circle join <code-or-link>` shows the circle's name, who invited
  you and what joining means. It joins only with `--yes`. People in the circle
  can then send requests to your machines that share with trusted circles,
  and you can send requests to theirs.
- `potluck circle list` shows your circles, the people in them and the models
  their machines are offering right now. `potluck circle leave` and
  `potluck circle delete` need `--yes`.
- A machine with only the CLI can now lend to a circle. The engine registers
  its own machine key when you sign in.
- When no machine in the circle offers the model, `potluck run --scope circle`
  now says so plainly.
- Security: a machine now answers another machine only when its own mesh
  daemon lists that machine as a reachable member of your household. Before,
  any device with an address in the mesh's range, which Tailscale also uses,
  could read the machine's name and hardware, and with sharing on could send
  it requests.

A circle request goes through the Potluck coordinator to one machine in the
circle. That machine sees the conversation. Coding agent sessions, batch jobs
and projects with a model lock still run on your own machines only.

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

When the CLI uses the desktop app's engine, update the desktop app to 0.1.10
as well. Restart a running engine after upgrading (`potluck down`, then any
command).

Standalone archives and checksums: [downloads](https://github.com/newtorob/homebrew-potluck#downloads).
