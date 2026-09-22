class Presmith < Formula
  desc "Create and edit local HTML presentations"
  homepage "https://github.com/RyoOuchi/Presmith"
  url "https://github.com/RyoOuchi/Presmith/releases/download/v0.2.0/presmith-v0.2.0-aarch64-apple-darwin.tar.gz"
  sha256 "f5f10856a169b141bdfdfbd562639ee9c823e2860b70c6c591f54487900e55ae"
  license "MIT"
  revision 1

  depends_on arch: :arm64
  depends_on macos: :sonoma
  depends_on "node@24"

  def install
    libexec.install "presmith"
    (bin/"presmith").write_env_script libexec/"presmith", PATH: "#{formula_opt_bin("node@24")}:$PATH"
    prefix.install "LICENSE"
    doc.install "README.md", "RELEASE-NOTES.md", "THIRD_PARTY_NOTICES.txt",
                "RUST_STANDARD_LIBRARY_LICENSES.html", "BUILD-INFO.json"
  end

  def caveats
    <<~EOS
      Create a deck and install its local renderer:
        presmith init my-talk
        cd my-talk
        presmith setup
        presmith edit --open

      The setup command downloads Chromium and renderer packages into the deck.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/presmith --version")
    system bin/"presmith", "init", testpath/"deck"
    manifest = JSON.parse((testpath/"deck/deck.json").read)
    assert_equal %w[intro workflow next], manifest.fetch("slides").map { |slide| slide.fetch("id") }
    assert_path_exists testpath/"deck/lib/LICENSE"
    assert_path_exists testpath/"deck/tooling/renderer/package-lock.json"
    assert_path_exists testpath/"deck/lib/decksmith.js"
    assert_path_exists testpath/"deck/slides/intro.html"
    assert_path_exists testpath/"deck/tooling/renderer/pptx.mjs"
  end
end
