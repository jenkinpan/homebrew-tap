class CargoFresh < Formula
  desc "A Rust tool for checking and updating globally installed Cargo packages"
  homepage "https://github.com/jenkinpan/cargo-fresh"
  version "0.1.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-aarch64-apple-darwin.tar.gz"
      sha256 "8b64000344b9a3286f589f6c08e9a8f6ce602c16f83cb281bf543ee765ead34a"
    else
      url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-x86_64-apple-darwin.tar.gz"
      sha256 "4419b7433743636224f3e9431c407b2ec99a5a96885f282e4e9e80e3989b335f"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/cargo-fresh/releases/download/v#{version}/cargo-fresh-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "da356be38a541ac45099087a9a16eb105224b5cf713139e4d465f27f33e47969"
  end

  def install
    bin.install "cargo-fresh"
  end

  test do
    assert_match "cargo-fresh 0.1.0", shell_output("#{bin}/cargo-fresh --version")
  end
end
