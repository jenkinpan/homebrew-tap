class CargoFresh < Formula
  desc "A Rust tool for checking and updating globally installed Cargo packages"
  homepage "https://github.com/jenkinpan/cargo-fresh"
  version "0.12.8"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-aarch64-apple-darwin.tar.gz"
      sha256 "95a3bce59926606c37d8c303d6e33fc75ee06d15b99c3abcaed7e8445c61e71f"
    else
      url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-x86_64-apple-darwin.tar.gz"
      sha256 "fc75d9f13acbc261b322bfc6e9acb622e96d139737642af660bc246f214249c4"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "bfca23b50f5ee4528b4b269c2a5671b5a4b45cd351f112a1b0e37619fe4cf30f"
  end

  def install
    bin.install "cargo-fresh"
  end

  test do
    assert_match "cargo-fresh 0.12.8", shell_output("#{bin}/cargo-fresh --version")
  end
end
