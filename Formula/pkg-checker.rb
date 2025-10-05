class PkgChecker < Formula
  desc "CLI tool for checking package versions and updates"
  homepage "https://github.com/jenkinpan/pkg-checker-rs"
  version "0.8.0"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-aarch64-apple-darwin.tar.gz"
      sha256 "cfd71a2181b35de47210fffa24513a228bd2dc3fc11491085ac52f5c3221dd92"
    else
      url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-x86_64-apple-darwin.tar.gz"
      sha256 "c88d3a622b4b6f8c952e65e00e42a33cce2658574f94294c546e844f748547c4"
    end
  elsif OS.linux?
    url "https://github.com/jenkinpan/pkg-checker-rs/releases/download/v#{version}/pkg-checker-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "82193086a157f9a9ba7a2bc75c08cf3f58f22e9cee80f605f48a737abe27cca3"
  end

  def install
    bin.install "pkg-checker"
  end

  test do
    assert_match "pkg-checker 0.8.0", shell_output("#{bin}/pkg-checker --version")
  end
end
