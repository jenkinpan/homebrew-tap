class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "refs/heads/main"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/vrefs/heads/main/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "0f91bd6fac5240afcac8f37350741e5169de85ef8a173a7b0e043affa862116b"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/vrefs/heads/main/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "698dc4d177f7e7dfb2d0ca27e696b87d3d24c2117808ab1243a27de2ac482f5b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/vrefs/heads/main/devtool-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f78e922a267f890d9fb4e05de04f44f35e87a780c5e61ef9316f253fd8c3acf2"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/vrefs/heads/main/devtool-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1faa74f2f5a1f4dd67b1be0f3d32e5d62236a0ab5b9e27e5d7b57c19e7d5b5f0"
    end
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool refs/heads/main", shell_output("#{bin}/devtool --version")
  end
end
