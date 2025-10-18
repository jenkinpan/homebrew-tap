class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.11"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "350593a7705ea79b267c4b37fe58ec255fba9c760084086b39187fbeb757f489"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "39a5471fae87ccb54cebb256d4ecc9daee1ab60806ee419258f13bdc84738cb6"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ff000587b194d5e5152ff7a95565cd7276634c43271399f8a8d3873cf19a0800"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.11", shell_output("#{bin}/devtool --version")
  end
end
