class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.21"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "7b5170baf26b6cd8de59b73555343c3438bebe10db5b66f5fe317a92251a00dc"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "e2b64269bc1c2c1342b863e2e34e945f1a0bb81a3e8938a4ff60ef5e2758fe9c"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0c8108b9c90f16730a918f76e716230637f0a8a3abd7e2e423529d141f76a6bc"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.21", shell_output("#{bin}/devtool --version")
  end
end
