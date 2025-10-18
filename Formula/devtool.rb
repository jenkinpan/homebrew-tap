class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.12"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "fd8c4ec97e222b0a882ec7176d866d1bd4562b6c7f9031b1714787d838d73e40"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "b71d5e00d67f8bceace5354272031c353dd4eddcd47090e33429a91d42e80db6"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "88b6b7030f18cae71ec9b0c97ef1a5da3ca36639f619811781cb703770096ffe"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.12", shell_output("#{bin}/devtool --version")
  end
end
