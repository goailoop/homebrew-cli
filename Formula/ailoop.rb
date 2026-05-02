# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.34"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.34/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4f29834122980f86191ddc46d9b4314ce747146c578fb544d60c7dde4f54abae"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.34/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d418bc94f2006b9b0810d29f15a5d6da51f358cf4b0efab981e122980971b195"
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
