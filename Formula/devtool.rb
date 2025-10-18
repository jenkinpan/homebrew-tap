class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.8.0"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "0b0121a58f2962c015b91265e581632bff7dbcb7399992aaadff73765d0aafb8"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "930b39de56589ebd8c60bdc93857947d626a99434b32dfc0c0228cc7638f2b72"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "65fc5779501dae13c7a64a5bc5cf29c525ffdbdfc00e1fd3c3e8da01a07bdfae"
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.8.0", shell_output("#{bin}/devtool --version")
  end
end
