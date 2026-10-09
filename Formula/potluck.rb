class Potluck < Formula
  desc "Local AI and machine management from your terminal"
  homepage "https://trypotluck.ai"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sequoia
    on_arm do
      version "0.1.9"
      url "https://releases.trypotluck.ai/cli/0.1.9/potluck-cli-0.1.9-darwin-arm64.tar.gz"
      sha256 "08e8c1658ae1e485234ac7947814e8c3a56c968edfe2f6a2f851b85675d36ba5"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      version "0.1.9"
      url "https://releases.trypotluck.ai/cli/0.1.9/potluck-cli-0.1.9-linux-x64.tar.gz"
      sha256 "24628724731cd1a98793a2dfb1059f893b74078cc33d5838febe750ea89f9281"
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
