class PkgChecker < Formula
  desc "CLI tool for checking package versions and updates"
  homepage "https://github.com/jenkinpan/pkg-checker-rs"
  version "0.8.2"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-aarch64-apple-darwin.tar.gz"
      sha256 "36488fa18bfcaaaea15437eef5f3c1eb47ce569b0d1de7f96aba0c005d4b05bb"
    else
      url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-x86_64-apple-darwin.tar.gz"
      sha256 "d1da29649534144105c2333fcd07fdce2ce03bdc09c52d66c68f57df0e1c6156"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "fa0a86fea44b281ab41e52d4efb047ffaf9bb9badd86e567004fbb7d4d075c06"
  end

  def install
    bin.install "pkg-checker"
  end

  test do
    assert_match "pkg-checker 0.8.2", shell_output("#{bin}/pkg-checker --version")
  end
end
