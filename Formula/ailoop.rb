# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.23"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.23/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d0975926585c9934894ef28fe82310222117f99bcc2b602af4982a602767b0a7"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.23/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8e2e49d9208313abeed75643869e801c7b488d4049a03a00c0de94ef2a8db188"
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
