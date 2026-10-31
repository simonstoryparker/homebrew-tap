class Padkit < Formula
  desc "Controller toolkit with guided browser setup and a typed JavaScript SDK"
  homepage "https://github.com/simonstoryparker/padkit"
  url "https://github.com/simonstoryparker/padkit/releases/download/v0.5.0/padkit-0.5.0.tar.gz"
  sha256 "2d5e48ffa9db1692e1c4ce65441da35397cab965d588defcdbd0342d9e6cc51c"
  license "MIT"

  depends_on :macos
  depends_on "node"

  def install
    system "sh", "native/build.sh"
    libexec.install "package.json", "packages", "extension", "native"
    (bin/"padkit").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/packages/cli/index.js" "$@"
    SH
  end

  def caveats
    <<~EOS
      Run padkit setup, then load the generated extension once per browser profile.
      Settings and extension files are kept in ~/Library/Application Support/Padkit.
      Selecting PowerA installs an optional user service; no service starts during brew install.
      After upgrades, rerun setup and reload the existing extension.
    EOS
  end

  test do
    ENV["PADKIT_HOME"] = testpath/"settings"
    system "sh", "-c", "#{bin}/padkit setup --browser chrome --profile Default " \
                       "--site example.com --no-open < /dev/null"
    manifest = JSON.parse((testpath/"settings/chrome-Default/extension/manifest.json").read)
    assert_equal ["https://example.com/*"], manifest["host_permissions"]
    assert_path_exists libexec/"native/build/PowerAInput"
    assert_path_exists libexec/"native/build/PowerABrowserHost"
  end
end
