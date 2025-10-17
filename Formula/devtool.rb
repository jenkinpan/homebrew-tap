class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.7.4"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "57ec2651b588726502cb21ceee3c76683db0da720986a3d6156447d8e75d75f4"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "9e59ddd3561a5856bed9898d71a11aa257ca29bfc7e097df2d97a0425ac0f23f"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "3a2a56e16b99a80c9e40b0d4be9404cc788af96695bbfb054ec18fc538f49824"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.7.4", shell_output("#{bin}/devtool --version")
  end
end
