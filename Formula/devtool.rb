class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.5.6"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "1a94664a1a88c91c2bd479627e49e79b7e1820a063c9c61fdc6af41e2062471b"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "a6807dc67527f7c10be536bbcbf01a2372acc5f6b287396210c72f56858178d7"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "5c314bd093858c56bd234a7d70818dee72026ad017db41009893371f36fbfbf9"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.5.6", shell_output("#{bin}/devtool --version")
  end
end
