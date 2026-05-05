# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.43"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.43/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9b3feb63c2d0f4f56264495e8e44e11def8e1e642bce06b43ce8ef27d10abc73"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.43/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "2d35e240f03b236ab3fdb6c54cc12d09d12846e2c8cd8389bd1a9c680e4d906c"
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
