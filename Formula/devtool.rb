class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.7.72"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "b4d1790931697c221e4df39882bc9b71c38fc084ba3aadcebb9adbef94cccd2e"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "242a4b78ce0bf865b2eb6f9774167b62f8fbdd1907a7bf9ccf27ff7ff21968ef"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e52e59c700477c8d30a0e962b95988ca37fde2d70d7af5da2b6369441f6c6d62"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.7.72", shell_output("#{bin}/devtool --version")
  end
end
