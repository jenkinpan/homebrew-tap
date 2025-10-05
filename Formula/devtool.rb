class Devtool < Formula
  desc "CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages"
  homepage "https://github.com/jenkinpan/devtool-rs"
  version "0.5.2"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-apple-darwin.tar.gz"
      sha256 "d0eb14eb91c23ff04f4f9132f61198781e71dfe1358be68840fd2d0895dab041"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-apple-darwin.tar.gz"
      sha256 "62e4e438f05936afebd53a43a3a5e1b2dddc3d2f78182ddd8df053e037c830f2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dc4b53f869ae8d0bfc3c251b03ed6c1aeea1cd610ddd92fe05235d58a4435753"
    else
      url "https://github.com/jenkinpan/devtool-rs/releases/download/v#{version}/devtool-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d397a5a210d32287e3da642dfb9f779f58bc27205fe504a5086d1325c721e4f8"
    end
  end

  def install
    bin.install "devtool"
  end

  test do
    assert_match "devtool 0.5.2", shell_output("#{bin}/devtool --version")
  end
end
