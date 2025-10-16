class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.7.1"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "b168571d57d4e74f072998b083a8d59ef94dda3a5248151c8d807990624844e5"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "33d11344ee6b1ae266af022eabe56d9d25e7baacab4f182336bf7085b074d772"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c0e07e9566ab819f5c72ce286bd68f8a641bc327a8baa29a947b10ac1d70503b"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.7.1", shell_output("#{bin}/devtool --version")
  end
end
