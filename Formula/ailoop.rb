# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.16"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.16/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c578a923b51143d0ee82c6cdf23a339e33979263c1ebaf8c760093a5f0dcfd93"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.16/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "752faeaa52d7f7f4c8cebff815beac3eb61c8b66588dc8e4ed388423e68179c4"
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
