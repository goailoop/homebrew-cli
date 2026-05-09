# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.3"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.3/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "24d054f98aafc8a5eaf7b8eba765e44f855e51444b74a1c87dd3f58302ff973d"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.3/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "45c462b9254b75b4a33c5ff9e05d3aa5a6c7130ca9a859ce3fb3bf9429969edb"
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
