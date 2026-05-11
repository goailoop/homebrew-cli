# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.7"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.7/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "088998a3e56b3e6cd5a9ebb91bb609f3a9c8cb0c151ada3635a232d24b1c1c17"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.7/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "0dd0a3bb7d7d990f3848af55cc34fa1d788b546dc39ef97fcfa59d2cccf9ddd3"
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
