class PkgChecker < Formula
  desc "Rust tool for checking and updating globally installed Cargo packages with interactive mode"
  homepage "https://github.com/jenkinpan/pkg-checker-rs"
  version "0.7.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-aarch64-apple-darwin.tar.gz"
      sha256 "" # Will be updated by CI
    else
      url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-x86_64-apple-darwin.tar.gz"
      sha256 "" # Will be updated by CI
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "" # Will be updated by CI
    else
      url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "" # Will be updated by CI
    end
  end

  def install
    bin.install "pkg-checker"
  end

  test do
    assert_match "pkg-checker #{version}", shell_output("#{bin}/pkg-checker --version")
  end
end
