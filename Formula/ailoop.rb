# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.38"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.38/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "1c880f19f97bcbbc6d8ba416867524b57c0eb7c7d9c0fc864021e73be907f33d"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.38/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e500b4088c0db38a8bee7a77d488d31a722d20a5cabdd9d7fa2271f9890dbe63"
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
