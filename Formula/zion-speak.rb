class ZionSpeak < Formula
  desc "Mac-native video transcription and subtitle clipping"
  homepage "https://github.com/dawei101/zion-speak"
  url "https://github.com/dawei101/zion-speak/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "33089eb51c1c5442feb8eeef5752dc6083a8de14c06af7d6bc65c4e21868a366"
  license "MIT"

  depends_on arch: :arm64
  depends_on "ffmpeg"
  depends_on :macos
  depends_on "python@3.13"

  # Online install: mlx and mlx-whisper publish wheels only on PyPI
  # (no sdist), so brew's standard virtualenv_install_with_resources
  # cannot resolve them. We build a venv and let pip pull every dep
  # online at install time.
  def install
    python = Formula["python@3.13"].opt_bin/"python3.13"
    system python, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "-v", buildpath
    bin.install_symlink libexec/"bin/zion-speak"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zion-speak --version")
  end
end
