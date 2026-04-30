class ZionSpeak < Formula
  include Language::Python::Virtualenv

  desc "Mac-native video transcription and subtitle clipping"
  homepage "https://github.com/dawei101/zion-speak"
  url "https://github.com/dawei101/zion-speak/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0a4e289ac73aa5dedd28023c97646e6fdc5de93c46bc08aa157d5902122c0018"
  license "MIT"

  depends_on :macos
  depends_on arch: :arm64
  depends_on "ffmpeg"
  depends_on "python@3.13"

  # Online install: mlx and mlx-whisper are wheel-only on PyPI (no sdist),
  # so the standard `virtualenv_install_with_resources` flow can't resolve
  # them. We let pip pull every dep from PyPI at install time. This trades
  # offline reproducibility for the ability to ship Apple Silicon ML deps.
  def install
    venv = virtualenv_create(libexec, "python3.13")
    venv.pip_install buildpath
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zion-speak --version")
  end
end
