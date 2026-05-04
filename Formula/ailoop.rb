# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.40"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.40/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "63a531811a6848a081d1248701a12d95bace25fcca3c9b86c3c800f4dd7f21a4"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.40/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "5e22e3ed4e5cb92215e2780331b8cb7e8e46a6f316a93ba003cc02628eed73e6"
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
