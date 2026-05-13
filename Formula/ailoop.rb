# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "1.0.8"
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
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.8/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "1e7a3929410af7ac3659964898acb962178f9501b6ab993d77b7378462bb288f"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v1.0.8/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6eb0b157d4c08e5a0d746f30f2586887ece8932098d2294c0b578d914a5ded22"
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
