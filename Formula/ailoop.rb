# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.33"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.33/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0c44f50f8d6bb1752552ac67a42fc28983f8600dfb62490d6ef221b3c72bf5dc"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.33/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9be687a732569f421606ebbc2e6f572e7d4e623e7f7653b5501e558f95058254"
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
