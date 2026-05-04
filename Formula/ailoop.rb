# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.39"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.39/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "10f5c6c1ddef00bdfff3a89f4a9ae1d1df17e751be552edaef12b21dc5dffb4f"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.39/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ba2abe946ed664d4ac6914d09a46dff8058474fcdf012958dbf9b6df5ac5f254"
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
