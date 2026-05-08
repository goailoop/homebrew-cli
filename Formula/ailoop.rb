# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.46"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.46/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "832ba360e1a1786ec6020b5f137f3ac221d9c179590d91084a132230a5e2ae8f"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.46/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "0b97eec3b12adec710c7ae92a6419eb6512d31005e778874190b85da9c6a1bbd"
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
