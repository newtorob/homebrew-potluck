# Potluck CLI 0.1.10

No new commands. This archive carries the engine from desktop 0.1.11.

- A machine that lends reconnects to the coordinator faster after its loaded
  model changes, and a long healthy session no longer leaves a long reconnect
  delay behind when it ends.
- When the engine cannot reach the coordinator for a circle request, it now
  says so, and no longer reports it as a failure on the other machine.
- Groundwork for direct links between circle members' machines is in the
  engine. It is switched off on the network, so circle requests still go
  through the Potluck coordinator, as before.

The fix in desktop 0.1.11 for two of your own machines losing their direct
connection is in the mesh service, which ships with the desktop app and is not
part of this archive.

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

When the CLI uses the desktop app's engine, update the desktop app to 0.1.11
as well. Restart a running engine after upgrading (`potluck down`, then any
command).

Standalone archives and checksums: [downloads](https://github.com/newtorob/homebrew-potluck#downloads).
