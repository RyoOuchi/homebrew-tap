# Homebrew tap for Presmith

Install [Presmith](https://github.com/RyoOuchi/Presmith), a local CLI and visual
editor for HTML presentations:

```sh
brew install ryoouchi/tap/presmith
presmith --version
```

The formula supports **Apple Silicon Macs with macOS 14 or newer**. Homebrew verifies the release archive's SHA-256 checksum and
installs Node.js 24 with npm. Presmith uses this tested runtime automatically;
your shell's default Node version does not need to change. Rust is not required.

## Create a presentation

```sh
presmith init my-talk
cd my-talk
presmith setup
presmith doctor
presmith edit --open
```

`presmith init` includes the complete Codex skill in `.agents/skills/presmith/`;
open the project in Codex and use `$presmith`. To install it across all projects,
run `presmith skill install --global`.

`presmith setup` reuses a shared cache of pinned renderer packages and Chromium
across matching decks. Use `presmith setup --local` to keep dependencies inside
one deck. For manual installation and exports, see the
[installation guide](https://github.com/RyoOuchi/Presmith/blob/main/docs/install.md).

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

[Presmith's tagged-release workflow](https://github.com/RyoOuchi/Presmith/actions/workflows/release.yml)
updates this formula automatically after building, publishing, and verifying a new
release. It installs and tests the formula before pushing here. Follow the
[release instructions](https://github.com/RyoOuchi/Presmith/blob/main/docs/releasing.md)
to bump the project version and push its matching tag.

A dedicated deploy key named `Presmith tagged releases` grants that workflow write
access to this tap. Its private key is stored in Presmith's `HOMEBREW_TAP_SSH_KEY`
Actions secret. No credentials belong in this repository.

For manual recovery, update the formula URL and the matching SHA-256 from the
published release's `SHA256SUMS`, and remove the old `revision` when the version
changes. Never replace an existing release archive in place.

Edit the formula in Homebrew's tap checkout (`brew --repository ryoouchi/tap`).
On a supported Apple Silicon Mac, verify the change before pushing:

```sh
brew audit --strict --online ryoouchi/tap/presmith
brew style ryoouchi/tap/presmith
brew reinstall ryoouchi/tap/presmith
brew test ryoouchi/tap/presmith
```

The formula test creates a fresh deck and verifies its manifest and bundled runtime
files and Codex skill without downloading browser dependencies. Presmith's release checks cover
its browser workflow.

Presmith and this tap are available under the MIT license.
