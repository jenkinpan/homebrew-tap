class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "v0.8.15"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "74cb45021f4fdef0936016416bd8ba534add24fe4d23cb6d0c848e7ca0e780fb"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "fb9ea8bc97cf456222a911146339a1cc61c2e18b810a37c8e93761597824ae8c"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ed20e2344d2048910d37860294e34f11285deb9aa159248d684027d277dd51dd"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool v0.8.15", shell_output("#{bin}/devtool --version")
  end
end
