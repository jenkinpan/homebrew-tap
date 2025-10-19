class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.17"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "5724b84b4bcb477bb4a842989f6f99905b403c28ddf41ff31765e0ec601b0e18"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "de5eab6a4d185e3eff8857c30fb031a2a1976e7e5b1926738650aa392b9a1f98"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "062689eaba4e8d1eb4b1d0410326d56659e12de9ea5689c1d1f9c69f2b097bcb"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.17", shell_output("#{bin}/devtool --version")
  end
end
