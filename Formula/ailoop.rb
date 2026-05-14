# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.9"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.9/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b07f7c2cec6499d7c0242835b9f4528977143af0729264c54c4156c6477c2d23"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.9/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d1b7e6c48ec7996e271daa2f83d0de872baf85e6d2287ee5c2f5124af7dde340"
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
