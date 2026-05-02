# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.35"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.35/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9ba96cd4f2dbe2a007f4338382e68e3967023ff51314a4745a729145c5cbbf37"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.35/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "51837c75f6f5c8e89c0be98755fbd60e9cfa4ce14a8764f7eb4b15c448cbd8fc"
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
