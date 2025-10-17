class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.7.6"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "bd11b5c39a660584d6be971c368a9a5b9ae72408ff7bcbe8ada7529fc9f54978"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "8ad2d7f48ffafb63ea24267a5be392c9966885347df1a043ec206f11bad6d86f"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "dacacd3984a1eab8b0c01ca42fe29c3f91acc94a55ca3e9e992001a9e0975fb1"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.7.6", shell_output("#{bin}/devtool --version")
  end
end
