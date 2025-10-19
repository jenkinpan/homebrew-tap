class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.13"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "b8ddde42c45e9371a257de0a79678b7d3ca812664c0e3c7a27bb2e1a46ff7e89"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "cad860c40ac9b4c8d01a39cfd5c50e7c8b7719928bf46d1f1b81e91f30e7d47b"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e22559fac01256979485fab8c5f14b5cadd1850aba6cd59d804536deb6946553"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.13", shell_output("#{bin}/devtool --version")
  end
end
