# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.10"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.10/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ba2e708cd4ac058bbb78b350bc6bc3722ab0e03fe3a64555d0374fe041f7f9c3"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.10/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7835737ca2edf101481ab48d3c92bd7dee00019560bd235b0702a229e32ca054"
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
