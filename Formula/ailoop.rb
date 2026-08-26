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
        sha256 "cdb49d4648b9177bc23b5646521fd837f62988141e0f00042566fee317ea82ce"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.14/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "684630327a6cabd34ce410cb4c44d4a8411552aff3e143b5cfa8de900b18d6b3"
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
