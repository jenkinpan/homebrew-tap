class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.7.3"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "0a91c45647e63f83c64bad2287c81bc9dcf5cad7fe037154e3cb71d4f64f7e42"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "375d2c74138d28faad23cb181275ede510a56fe35945319368f1e84baacf6961"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "7cf368d7eb2386ceb3c13685e719966953a48288d222a2a537c8dc039a033379"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.7.3", shell_output("#{bin}/devtool --version")
  end
end
