class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.16"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "73634524c18b90094df3b0830a04df83cc4b94c973966968cda63590b9bc3a4e"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "293bdbfcc1b3c866f5c8edea1f988f392b3cbce038156399f6a5672a43ed7d5d"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9112a64194ea60e6ee4a560526e8866c16fbd0cda4b58994be71213a40fce202"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.16", shell_output("#{bin}/devtool --version")
  end
end
