# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.4"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.4/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "fa8502648c25cf919060e5bdeea2391d35538622de18d799f2f24ea8cc7f7b92"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.4/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e45f501c99aa2b21ad38645c583f80c05e08f53d94753062357c59a90fc6ab60"
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
