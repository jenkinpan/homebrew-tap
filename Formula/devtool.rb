class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.20"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "50c22e667a3da7a93a26d2c6e0790c152b5c403ae9eddbf34821fc971695a9fd"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "0eda97f6ddc9a7bb7a30199136bc55aeb9c3a0329cdca3ca6756fa67a68fe1da"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "5d850399479b5f93da6a63166fb52dac98f936ae8c05e45d6d0200f5def2c018"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.20", shell_output("#{bin}/devtool --version")
  end
end
