class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.5.5"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "9a7ccd762b98bd9d4393a577b7b28dd94ea7d0009f7b863f66c62346cebd0eb7"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "9e762d62b79465f66b0503c70a51e9e6742c63897bec77dc7dde3f550f1bdab6"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "430fd01a5602b818273dbd2ccdf397e7f000b9e33f9da22d0d7511756b6e43e1"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.5.5", shell_output("#{bin}/devtool --version")
  end
end
