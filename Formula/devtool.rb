class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.10"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "398dab75a33f3151b31c425a0d497067f5d24d4453ab327f5c6e044254cdb5d5"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "b5231899818102ef44caf15b8c0fad80b38e5d67cca3eb3ce55ac407050abf48"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "3cce00ec3115526c429e87905e5ea364a0a3491b341215de3677bd6c9d1c65f9"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.10", shell_output("#{bin}/devtool --version")
  end
end
