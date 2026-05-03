# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.36"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.36/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3bf247d87251514a9a0cffa0c6fc1a9cb0ce26e2a1797001f840594a15053434"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.36/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "1dc0c0f7a87858105f9c7338291e41680e68b6d587ce36f082597d78d707be02"
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
