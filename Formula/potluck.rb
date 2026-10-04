class Potluck < Formula
  desc "Local AI and machine management from your terminal"
  homepage "https://trypotluck.ai"
  version "0.1.6"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sequoia
    on_arm do
      url "https://releases.trypotluck.ai/cli/0.1.6/potluck-cli-0.1.6-darwin-arm64.tar.gz"
      sha256 "eb329c7b08d1b679920ec630521162fa3a55614fdccaeaff0fcd05d7b3d6ce37"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://releases.trypotluck.ai/cli/0.1.6/potluck-cli-0.1.6-linux-x64.tar.gz"
      sha256 "3e9a14c8b5e280c0c6cd37dc8a51084e986b1bb4dd8dec098f7648243631594f"
    end
  end

  # Preserve the bundled runtime libraries and their relative install names.
  preserve_rpath
  skip_clean "libexec"
  depends_on "node"

  def install
    libexec.install Dir["*"]
    (bin/"potluck").write_env_script libexec/"bin/potluck",
      POTLUCK_NODE_BIN: Formula["node"].opt_bin/"node",
      POTLUCK_HOMEBREW: "1",
      POTLUCK_BREW_BIN: HOMEBREW_PREFIX/"bin/brew"
  end

  service do
    run [opt_bin/"potluck", "serve"]
    keep_alive successful_exit: false
    restart_delay 5
    throttle_interval 5
    stop_timeout 60
    working_dir Dir.home
  end

  def caveats
    <<~EOS
      Start local setup with potluck setup --no-input.
      Optional background runtime: brew services start potluck.
      Stop a runtime started by potluck up with potluck down before switching.
      Sign in with potluck login; it opens your browser to approve this terminal.
      The mesh daemon is installed separately; potluck doctor checks its readiness.
      This package does not enable gateway access, contribution, or network sharing.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/potluck --version")
    assert_match "potluck service", shell_output("#{bin}/potluck --help")
  end
end
