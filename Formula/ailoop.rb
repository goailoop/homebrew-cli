# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.18"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.18/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "cdd58bd8f9f85fe4793dfd0dcff112005101c8e37582f9361a94845153eedf69"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.18/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d8dc07bb2c1281135fb7df1c3071c8d3831d3eb9303545ed4cc17f5c993f7c37"
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
