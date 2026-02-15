# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.27"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.27/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "8528c95ee6a2454988275063bb162d8e68bdcc6f46c00b6c80716ec3a3520266"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.27/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "51c0945e42100fe3f1cbf1ac6d57ff8922031be29c828f32eaa9d00a4762c078"
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
