# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.6"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.6/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "596d9777bf769614ee975eca21544ca896d41734b74f08da66fcf6c75e62bce0"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.6/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c7799cbfb694d03bbb452de7a6099e56c69c4038acfad679ada1bcb6e8c57a9a"
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
