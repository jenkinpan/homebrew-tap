class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.7.7"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "32e573bd32466290db811631b9b3b8aef805bb94d2fce47314d33c6462744d28"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "65916dbcf81bcef0ab4a03a0912be0594865f36c7e8ca9fb140019c3ac7b573a"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "7f5e2b3ccbba4a56a91f99a013f9355324f9a1e4047544a833f9d476be0dd394"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.7.7", shell_output("#{bin}/devtool --version")
  end
end
