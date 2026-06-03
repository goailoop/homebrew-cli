# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.11"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.11/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "230e1e130bd3b34af315feff5142af0fda60f41b83f0f926ee81df1717361b4f"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.11/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7dfd027d240e4c37b8252b09387163a6e20e6f567a11f996f66cad147b1a2beb"
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
