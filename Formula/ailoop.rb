# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.45"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.45/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "bcdca3f44bfd43bb0f16d3bec97402620d222ec8db7c03118f7b1bb07c02710d"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.45/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "521520b1e6fa2e4dcc68fce3e3069969ab1de460861deeb5d0b2baa9ad11dc09"
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
