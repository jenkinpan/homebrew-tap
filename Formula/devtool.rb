class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.5.4"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "8d1e059b9ec6e7466d44538b6c544d2c63e5a4a4cc60679ded70124e87194141"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "c571107460448014a0c2b1472a0b0a2e8fe3f6a33b071dbbad3adbc896459a23"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ab93444d68f33c79da8b72fd165a23df77eea92cd8c3e0b29b8cee99327bbec5"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4a16a57bf81ef39fc9ff661b77d5efa96c468f5252e5a2b589c034fb4edd53ba"
    end
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.5.4", shell_output("#{bin}/devtool --version")
  end
end
