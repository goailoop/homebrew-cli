# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.33"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.33/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e5b45c54e98b61a86047ffc22ce1c2f6ab8ae39a8755e5ac3fde77374b2b3d02"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.33/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "cb49fa26479a1fc5eaf017b915ba4dabc60f0f2a69f50f2d3c89520fc1b8ee48"
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
