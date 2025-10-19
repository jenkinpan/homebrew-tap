class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.19"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "956aadaa69e75affda8d22337900435f88f230f3454d3563059f7221df693f82"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "53a02d91356a16500b8b113936dbe379ec3e4b090e8a5ed344d15c5af1da9c56"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "38eb13a9d2134650f88ce9d4735adc3213cb3d3e7e73b00b84526128fddcd314"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.19", shell_output("#{bin}/devtool --version")
  end
end
