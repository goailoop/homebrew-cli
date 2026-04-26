# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.32"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.32/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "1a6a87ad97db3b9e66f2d2404bdc9f7de5a0a3c4e28ecc632f82b9267df90b83"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.32/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ad1509d0255f45922e5dda34365700aa11a41d3ce9c087a261f85d1153e4a218"
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
