# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.6"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.6/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "65d4998bd67619cbee2e09a863079c2e3ba2cf0fb0c7ae10c1db97cf2adb4784"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.6/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "358b228db0f5cb411e30552c862e13b25d0b584978f2eff4cc18a672374acdcb"
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
