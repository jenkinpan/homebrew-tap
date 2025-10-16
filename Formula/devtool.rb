class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.6.1"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "0da1f372c50395dfe2fb7e5380e6a5e08468131d8a04a71ad563579a198cdbad"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "ecc5458401dcf4413ff1dbf2ef2028e91ec5e807a5e46b857a98eca42e3ba5d7"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c7045f5c424964d5506a89032e592cbdb9c9bd5948e1b8b2085dec9803bb3a1f"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.6.1", shell_output("#{bin}/devtool --version")
  end
end
