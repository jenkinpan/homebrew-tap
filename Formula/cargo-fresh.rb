class CargoFresh < Formula
  desc "A Rust tool for checking and updating globally installed Cargo packages"
  homepage "https://github.com/jenkinpan/cargo-fresh"
  version "0.12.6"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-aarch64-apple-darwin.tar.gz"
      sha256 "f9451ffa5a211940c2a4211156843f2dd96bed88712531e3d32c596bd2ee05e2"
    else
      url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-x86_64-apple-darwin.tar.gz"
      sha256 "94ad7970aa995c57f4289d0fc838618360c50524e5b06d6a845b6acec69a8fa3"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "51d1d7025ff790a74b10145aef5069a2ef82e7e54c920f3f81941efdef3342ce"
  end

  def install
    bin.install "cargo-fresh"
  end

  test do
    assert_match "cargo-fresh 0.12.6", shell_output("#{bin}/cargo-fresh --version")
  end
end
