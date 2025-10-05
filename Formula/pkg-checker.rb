class PkgChecker < Formula
  desc "CLI tool for checking package versions and updates"
  homepage "https://github.com/jenkinpan/pkg-checker-rs"
  version "0.7.5"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-aarch64-apple-darwin.tar.gz"
      sha256 "3d4f7689326cdc3e1c901a515112cebbd4848a57265a96fb5e11482185a2621b"
    else
      url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-x86_64-apple-darwin.tar.gz"
      sha256 "37375d881956ff9ba9f41e179993d05c42f0cbe6283b0352012a67984d7228d5"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "06c910a48946b9cdff4650cfbdad2528c18068029bf128d6f90431a9b78c2cbd"
  end

  def install
    bin.install "pkg-checker"
  end

  test do
    assert_match "pkg-checker 0.7.5", shell_output("#{bin}/pkg-checker --version")
  end
end
