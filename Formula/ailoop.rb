# typed: false
# frozen_string_literal: true

class Ailoop < Formula
  desc "Human-in-the-Loop CLI Tool for AI Agent Communication"
  homepage "https://github.com/goailoop/ailoop"
  version "0.1.17"
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
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.17/ailoop-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c9772376dfd3175fa89bb29aae7ad9254a07ea84eafd1346bcef885d1abdf6cf"
      else
        url "https://github.com/goailoop/ailoop/releases/download/v0.1.17/ailoop-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e23e341297e8f035253aadb6c3a0579130d35c6433addf5e2edef478a46ea9d5"
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
