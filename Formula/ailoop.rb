# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.7"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.7/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d52e15376558006ba8b8dbbb9103ca623356e83fde6ce9d448523f9c72017ce0"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.7/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "5d23ccac9698a66cf70734677dfd39b500852c7a43f3e7c6797a8ae3d06a774f"
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
