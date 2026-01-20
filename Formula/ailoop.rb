# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.5"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.5/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "65d0aa514902974e1caa988db9e49f54f60e55e5bd6227bc691f6b87e90b9a54"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.5/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "3a455b9126f32c0f3975c55084d2b4242f2e787b779314a9ff2714a419d937a9"
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
