# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.2"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.2/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "7eae16c3b485fcb0ef505604c4ed06dcf660187fd174ba73671daa65dd2de198"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.2/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7ea1023fb552d70b39d6e22ae50854529f10da675631621d5d240ec8dbfd5df8"
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
