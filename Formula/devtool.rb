class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.6.0"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "2dfaf00d8e1d3ec32b0c75e88e320ace2839018dea76dd17a08b553c12ba2b06"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "2898caaab7b8d568c59a39154b61912b9120e2d8bed363e8746f147e37e60f1f"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d0999f6bde88133278c6ee4e7d36bd08e84732f534a5a72f5b94fb89f84c65da"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.6.0", shell_output("#{bin}/devtool --version")
  end
end
