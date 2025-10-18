class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.7.8"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "26e7410d3f2ff723a444cbdae24877e726455c5a2b665c101cc864f48be115b4"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "f371527135d1f55f3b0847498e6583de4b75d5704b74f0864ca376168a2a59b7"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "7d4d6ddb491adffb7a8307f32e1c6f26875303c7ab228d0f59fcdd479b7da0f0"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.7.8", shell_output("#{bin}/devtool --version")
  end
end
