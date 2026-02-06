# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.23"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.23/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9bba9967a62a4aa8f2f21cdf7175122a49ce340567dc983fe1587ec0528c0d86"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.23/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "75c9fd37eaa7380d60596cf3865f3eb3254b211755677e06456d24945f4c471c"
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
