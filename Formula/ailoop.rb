# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.6"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.6/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "60592ee5d9fe4450789254306b815e507859d2c433e3e9220fffc5d01c38aca9"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.6/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8081257ba6cf723e599accba41297f0b953e323572f7b1ba39ff8c870fa736b1"
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
