class PkgChecker < Formula
  desc "CLI tool for checking package versions and updates"
  homepage "https://github.com/jenkinpan/pkg-checker-rs"
  version "0.8.1"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-aarch64-apple-darwin.tar.gz"
      sha256 "d8dc38d875f8856eaa5b626d9b907dedf87a660dea367fc4b0971018d0ffa36f"
    else
      url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-x86_64-apple-darwin.tar.gz"
      sha256 "e3f87423bbb00d625f6716989543b60778d450b5752240ed0c1ce7748cf7c8d5"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "6f691f11160eb5d8a9b073f30941aef74cd9c5e3236abbd60f9f14e6cc6dcd44"
  end

  def install
    bin.install "pkg-checker"
  end

  test do
    assert_match "pkg-checker 0.8.1", shell_output("#{bin}/pkg-checker --version")
  end
end
