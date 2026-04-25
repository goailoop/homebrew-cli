# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.31"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.31/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a2c5d6b5525025011842af3c2eadfe0005b90857751d5801f1bbabb56965b7be"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.31/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "f7c892cb8f0876774f4bffa2974a2f7a6e9018e23f060862d721c41a52d08a25"
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
