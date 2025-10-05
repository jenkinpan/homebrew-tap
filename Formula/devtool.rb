class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version ""
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "4bbb35db4cf81d29454e7ea53488b50756cefeab987c7f4f2b2e15a433d834e1"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "9eb7fd13312153a64189870cb1e32e738e87714804caa183e2c7d13021a55dc7"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1c8860b8f9deea6682314ff145828a0e3389674598cf9195d1646d964ab91636"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "df9173ced236a2120e9087163b3bf2320f7725a25b2a828570c93793544eef36"
    end
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool ", shell_output("#{bin}/devtool --version")
  end
end
