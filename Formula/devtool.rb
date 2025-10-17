class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.7.71"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "553eb68b8d4fc4437cb0db6e1de8321044061fedb0890a578a81ef5912f1ff6b"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "0aab93b553ac743373dafa504a808fc5d111b4766e5265656433d673bacffebe"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "938ec78b103c33c7acddcdafd2617c80428025723143799d8699c789c5466b89"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.7.71", shell_output("#{bin}/devtool --version")
  end
end
