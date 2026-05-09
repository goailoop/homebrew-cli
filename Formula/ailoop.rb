# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.0"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.0/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6f19e00cfe09b92710e890d9d389466354c9a0aabdf530b3e2cb349c206b06cd"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.0/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "223c6318ada36157d806448ffdc3be2ffbeab9b72daafd2c7b11c659ef3510ed"
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
