class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.5.1"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "5d9a0c97ac51675d894cb4e46ace5f71a659aaef48f7d52c94c6409e50656fdd"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "962727a68a733448bb6d741b1d810a42991b3dc46ab4a4999d32a565f160d98d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a848c27aefaf615e4e801de4bd5367ae3752ba1b5b91b22535641912a3e363c2"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b738171981d9c930cbc469c6d4c48f3db3aab2786e37b4028cb181d8358088a1"
    end
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.5.1", shell_output("#{bin}/devtool --version")
  end
end
