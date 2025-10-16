class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.7.0"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "ff932979dbdbaaed3568ef8d8aa7f346f7a41c0b5afbc3a0488e66297f120bff"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "918a073c63f4b20f8348db40759f668b51983c3c629f68117bf0250526e22bf6"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "be20acd2dfbf8fc69282e8449bba88b2d59e34d930a8cde0b777c47434507c2f"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.7.0", shell_output("#{bin}/devtool --version")
  end
end
