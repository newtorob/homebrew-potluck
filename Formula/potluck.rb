class Potluck < Formula
  desc "Local AI and machine management from your terminal"
  homepage "https://trypotluck.ai"
  version "0.1.1"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sequoia
    on_arm do
      url "https://releases.trypotluck.ai/cli/0.1.1/potluck-cli-0.1.1-darwin-arm64.tar.gz"
      sha256 "a8db9da627ff085954ca77824d37f54af1403ebbdb7c3ccb2c2d99c69e18c3c8"
    end
  end

  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://releases.trypotluck.ai/cli/0.1.1/potluck-cli-0.1.1-linux-x64.tar.gz"
      sha256 "7ed3479288ea06a799a25b1f274621fd09007c3f81f9f27e9ba4241de1a069a8"
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
