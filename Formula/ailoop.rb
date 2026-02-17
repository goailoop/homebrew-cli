# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.28"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.28/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "52bf24731c873307558d64f74d4112396a16d87505e7bd2405d3775077ae700a"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.28/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "975d37ed48bcf18e3fbdc9d0b5e0ba5f1e8eddc6452d4df7d65726d4e53c7bd2"
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
