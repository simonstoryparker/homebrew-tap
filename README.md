# Simon Parker's Homebrew tap

```sh
brew install simonstoryparker/tap/padkit
padkit setup
```

[Padkit documentation](https://github.com/simonstoryparker/padkit).

Requires macOS. Node is installed as a dependency. The optional PowerA USB backend is compiled locally; setup installs it per user only when selected. User settings and generated browser extensions survive Homebrew upgrades.

To upgrade: `brew upgrade padkit`, rerun `padkit setup`, then Reload the existing browser extension.

MIT licensed. Release updates must change both the formula URL and SHA-256 checksum and pass `brew test padkit`.
