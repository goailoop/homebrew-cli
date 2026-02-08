# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.25"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.25/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "118fd46b02736ddf7f1195bbd39d9073db34ebc5cc0143d613d84cff83c162d2"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.25/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8df3d0a4f499504c760a49275c5ccbc41631b8b4575c5c79ca9224fa365db48f"
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
