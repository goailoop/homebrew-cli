# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.15"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.15/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a5c12508ac094586d8f4b50331227249895eb14ac4f0138659ae77b193bc8e59"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.15/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "56bf978cfb6d4548099a50d5c2b24f3d1f71c8f72795ea6b4e17c45fb7af2afb"
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
