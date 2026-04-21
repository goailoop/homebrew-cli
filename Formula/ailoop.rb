# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.30"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.30/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "1b71c5a32ba5927e62eb53e68c5e5d193fd97f3e826a44e43d886e2020501873"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.30/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "a70f1073dc1b99e9376d2dcff5f15b691a796f71dbb0e5f5982b7bd5fef37563"
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
