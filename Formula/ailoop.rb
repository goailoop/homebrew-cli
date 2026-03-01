# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.29"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.29/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "10e5857966ef856ff84808f94ea7e9127bfc38495cbcdc9aaf895aaa00239159"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.29/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "27437766525fe10eaf3638ed3d294a21c9896b8420c1fd08e66105e7840d65d1"
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
