# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.24"
  license "Apache-2.0"

  on_linux do
    if Hardware::CPU.intel?
      # Detect glibc version to choose appropriate binary
      # glibc >= 2.38: use gnu binary for full features
      # glibc < 2.38 or musl-based (Alpine): use musl binary for compatibility
      glibc_version = begin
        `ldd --version 2>&1`.lines.first.to_s[/(\d+\.\d+)/].to_f
      rescue
        0
      end

      if glibc_version >= 2.38
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.24/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "39fbcc96fe4a9f5647d3312458041bc3ba769180fadfa10bef664993d9446011"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.24/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "960da9cd8bfcfa4ae2c5f228b2bcf5544b04f07e5e125fd7571f5c887c72c216"
      end
    end
  end

  def install
    bin.install "ailoop"
  end

  test do
    system "#{bin}/ailoop", "--version"
  end
end
