# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.37"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.37/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "066053475dc6f7099661ec9f59a1de97c663f2475c95e1797e28a0ae7ba23208"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.37/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e4279989e0748a79b282c53af07a84f20c630e2acae5f637f128bc1e994a4ba2"
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
