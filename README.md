# Homebrew tap for Presmith

Install [Presmith](https://github.com/RyoOuchi/Presmith), a local CLI and visual
editor for HTML presentations:

```sh
brew install ryoouchi/tap/presmith
presmith --version
```

The current formula installs the v0.2.0 prerelease for **Apple Silicon Macs with
macOS 14 or newer**. Homebrew verifies the release archive's SHA-256 checksum and
installs Node.js with npm. Rust is not required.

## Create a presentation

```sh
presmith init my-talk
cd my-talk
presmith setup
presmith doctor
presmith edit --open
```

`presmith setup` downloads pinned renderer packages and Chromium into the deck's
`tooling/renderer/` directory. For manual installation, exports, and the optional
Codex skill, see the [installation guide](https://github.com/RyoOuchi/Presmith/blob/main/docs/install.md).

## Update or uninstall

```sh
brew update
brew upgrade ryoouchi/tap/presmith
```

```sh
brew uninstall presmith
```

Uninstalling the CLI leaves your presentation projects intact.

## Maintain the formula

After publishing a new [Presmith release](https://github.com/RyoOuchi/Presmith/releases),
update the version in the formula's URL and the matching SHA-256 from that release's
`SHA256SUMS`. Never replace an existing release archive in place.

On a supported Apple Silicon Mac, verify the change before pushing:

```sh
brew audit --strict --online ryoouchi/tap/presmith
brew style ryoouchi/tap/presmith
brew reinstall ryoouchi/tap/presmith
brew test ryoouchi/tap/presmith
```

The formula test creates a fresh deck and exports HTML without downloading browser
dependencies. Presmith's release checks cover its browser workflow.

Presmith and this tap are available under the MIT license.
