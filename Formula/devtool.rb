class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.18"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "fe16d3a1a5d0c498bf51f0cc9a9730a87152c6c8f96a99ad55bc41bacba0cfe7"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "bb0cb1e8d79f5895afd2dcf5fbad4c6a353578facc6e7f5c497c1e7bce1a8451"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ac737396a5480dc2f831da5739c545a8112982e713f9dd1241711375cd60f5bd"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.18", shell_output("#{bin}/devtool --version")
  end
end
