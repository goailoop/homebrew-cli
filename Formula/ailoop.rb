# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.19"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.19/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0a055ab68fe4d7eac715fbd103756ba240abf48f5bbb8d9d428d556cdf037b73"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.19/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "fc1348846c3178caf4fb8774e642284488a95d98f30da5a46ae3af7e4d4651e2"
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
