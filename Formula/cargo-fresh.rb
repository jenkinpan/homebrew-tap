class CargoFresh < Formula
  desc "A Rust tool for checking and updating globally installed Cargo packages"
  homepage "https://github.com/jenkinpan/cargo-fresh"
  version "0.12.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-aarch64-apple-darwin.tar.gz"
      sha256 "8e077c10e2bb765161eaf9910746be9f84c879438de6ea61834daee8c1fcb966"
    else
      url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-x86_64-apple-darwin.tar.gz"
      sha256 "3ef9d33b283f8daec2ed6f586802ff1c4a18fb1fc2767d83317cd5e9f9c65c7b"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "aacbaeced922ce7e299ebd225fb63da572f8df07284964c295bcfbdfa81625ab"
  end

  def install
    bin.install "cargo-fresh"
  end

  test do
    assert_match "cargo-fresh 0.12.1", shell_output("#{bin}/cargo-fresh --version")
  end
end
