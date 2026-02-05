# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.21"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.21/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "34dd57538e376b9317f2d61c1ec0c7f4499a3b48a5956795237b53994cdae853"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.21/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ae22576709b54be08e2d4fe73f3f4d70c23bf4edf9e1ef9a60a9651a531eb73d"
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
