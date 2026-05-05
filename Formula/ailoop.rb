# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.41"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.41/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "68d7ff88a7f900163bdd305c7567f0af580176ff16d2e20b9ee9d7fe8857fbd5"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.41/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8bfcc8a555abcc051c57a4e53bc3023f4b4954934568d1b663043e829f57ac8e"
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
