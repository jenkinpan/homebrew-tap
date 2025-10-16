class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.7.2"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "6620a52fda84da219c8fd5bacabf11af60c9ea87083e92dc2b468d15f0b5a36a"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "c803662f0c5e515cca6984a958d597298d5a87410acda522a6091195e0d2420b"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ca328f53dc27f34320806223fe0c83dba754b0fb803542fc1b7c8e6f114f38a8"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.7.2", shell_output("#{bin}/devtool --version")
  end
end
