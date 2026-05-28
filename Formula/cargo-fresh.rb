class CargoFresh < Formula
  desc "A Rust tool for checking and updating globally installed Cargo packages"
  homepage "https://github.com/jenkinpan/cargo-fresh"
  version "0.12.2"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-aarch64-apple-darwin.tar.gz"
      sha256 "0b97ffe5d518dfcbd7ca1b132a10c63e6cf167a95eec2e58e3d629ec9f698ca5"
    else
      url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-x86_64-apple-darwin.tar.gz"
      sha256 "8cb615f5cfcc3947236c3b7ee4a29451e367131da7a5f4d8410a190b3653e3af"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "99ff087dce02b1c4fc01d3e1a9f716c0b90c1c7ace645fb7aef7d4eb63b4e6f3"
  end

  def install
    bin.install "cargo-fresh"
  end

  test do
    assert_match "cargo-fresh 0.12.2", shell_output("#{bin}/cargo-fresh --version")
  end
end
