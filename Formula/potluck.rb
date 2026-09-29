class Potluck < Formula
  desc "Local AI and machine management from your terminal"
  homepage "https://trypotluck.ai"
  version "0.1.4"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sequoia
    on_arm do
      url "https://releases.trypotluck.ai/cli/0.1.4/potluck-cli-0.1.4-darwin-arm64.tar.gz"
      sha256 "9b3c6ecb15eaa96f67189837f25f8227353d00a9b34994977ed621bf3e6b749d"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://releases.trypotluck.ai/cli/0.1.4/potluck-cli-0.1.4-linux-x64.tar.gz"
      sha256 "5bd3c167ce45555b6ad9f8315d5eec91013fc7763dc7b19bacc0f19d8dcb0c5b"
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
      Browser device login is awaiting the account-service rollout.
      The mesh daemon is installed separately; potluck doctor checks its readiness.
      This package does not enable gateway access, contribution, or network sharing.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/potluck --version")
    assert_match "potluck service", shell_output("#{bin}/potluck --help")
  end
end
