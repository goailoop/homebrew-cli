# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.42"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.42/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c7e5b53e89b62c4af5c334c0285e42580655315ec571691bd5f30666359bd025"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.42/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "eb7c8e58f61763515a1e8ede6b1fa44f9eedce9a33d3269b29bfe4d66b40d419"
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
