# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.8"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.8/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5f56eb9ae691c772207bcaa521d8c50c598a8836074cd49e7c4f324095f02dd7"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.8/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "072ea262ca9aa08ae0eb7218851c5faa53103c9c99a31d1f50b2953704b87df0"
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
