# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.44"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.44/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "00409d9d40d95b737a5cf5d504134ba50e24755851bffb2c784a13d505c8e5b6"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.44/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ca4ed5e4b9a82dd7c362eddca1b6bdca5c1046192d071a9f6841c715d0e1d669"
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
