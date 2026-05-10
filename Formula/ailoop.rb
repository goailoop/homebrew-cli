# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.4"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.4/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "2a7a0f4542e93509a010c1094487e1b26b3f12375be7dc0fe59c7ba300848b8e"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.4/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ab05281f77b6013c2d6d390d5aa5ef7a6fc9dddb1292e85008aff99119233e22"
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
