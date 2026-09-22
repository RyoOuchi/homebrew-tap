class Presmith < Formula
  desc "Create and edit local HTML presentations"
  homepage "https://github.com/RyoOuchi/Presmith"
  url "https://github.com/RyoOuchi/Presmith/releases/download/v0.2.1/presmith-v0.2.1-aarch64-apple-darwin.tar.gz"
  sha256 "bd9eb5f65ea98cc38725758aa3cfc85e51eb8c3aea758132b26d894f2826b724"
  license "MIT"

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
      Create a deck with its Codex skill and set up the renderer:
        presmith init my-talk
        cd my-talk
        presmith setup
        presmith edit --open

      Matching decks share cached Chromium and renderer packages.
      Use presmith setup --local for a self-contained renderer installation.

      To install the bundled Codex skill across all projects:
        presmith skill install --global
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
    assert_path_exists testpath/"deck/.agents/skills/presmith/SKILL.md"
    assert_path_exists testpath/"deck/.agents/skills/presmith/references/creation-workflows.md"
    assert_path_exists testpath/"deck/.agents/skills/presmith/agents/openai.yaml"
  end
end
