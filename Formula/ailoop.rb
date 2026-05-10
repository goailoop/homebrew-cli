# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.5"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.5/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "1e7f79db2d762cd914253b3b8e41267dfde68a9404481c4b0eff0644b0a5f11f"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.5/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "f165b72d8df264c915d1c89b97340ccc8aeef9e6cc88e1063fbb241308ca120a"
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
