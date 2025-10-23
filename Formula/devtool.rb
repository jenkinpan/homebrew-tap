class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.23"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "446c1e6511e0c36259f4b8bbe891c01951988a24c1568863c75797a0f8ed4032"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "cfcb8da2386441ba2901deca4058f08bee3a95aa08520caf351ab9a8733e5a49"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "269aa9efc40045a3b33b6eb3ad1380c9c5999cefc39f22e94ca2a8c69f362ac5"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.23", shell_output("#{bin}/devtool --version")
  end
end
