# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.14"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.14/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4b640e74fef129d68bc0ad70a84a82bf83d20dc81a7da83454e8a23934890dc8"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.14/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "98dbd079ca4500d6c91f84ff85c478c17d6c8062820e660751240f4b6d3127d3"
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
