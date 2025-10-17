class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.7.5"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "9f2dad769da53ecc6c5d30941ef22bc7be275f3852ddbd3b3563fb4fa5a709bd"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "bf63137fde897c23cd1e72654540b60a8bf5f0f848415c96f14ce894e5cc61d5"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a67e2a96547ebe606456029231c63af4fa710628d5b371d03319ed9dd525a1b4"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.7.5", shell_output("#{bin}/devtool --version")
  end
end
