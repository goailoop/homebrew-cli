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
        sha256 "7b529c3952b36a1b3ff7b036a33e6c2f52624ccb01dc1250db7be921a08d5a7e"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.14/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "067b34c6bd2e6cb67c4663852eba05167e46d6e5c27fd28df6a035685c601c64"
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
