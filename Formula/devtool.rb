class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.22"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "e7d48be2387070e8b373f927a6f2df0a39cff9dd5ae9eacb2794307e5e139ac5"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "dfc14eb3791adc3bc35d310e25642157c25e2ae269001b7bf06d7c9be4c8d192"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b6cad1d204fbb4c5145457a540bb5009f843dd5873f981df4f6f758595f1efbf"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.22", shell_output("#{bin}/devtool --version")
  end
end
