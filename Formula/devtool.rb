class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.14"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "2b8f164ba65750b2ecbd5ccc5ca75210d1525b0e2615971e3f3b5d9eea1a6b14"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "fb0c449ba2ade24e05e931f70b3b6c678121c9b35610c4d7e4bdd7f4de9cf843"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f85950ff2ea8944e98b52e4bb0d491e9a26e9201df408893a937fd1096885d63"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.14", shell_output("#{bin}/devtool --version")
  end
end
