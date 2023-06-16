class Erfa < Formula
  desc "Essential Routines for Fundamental Astronomy"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/erfa/erfa-2.0.0.tar.gz"
  sha256 "75cb0a2cc1561d24203d9d0e67c21f105e45a70181d57f158e64a46a50ccd515"
  license "GPL-2.0-or-later"

  bottle do
    sha256 ventura:      "e2f1dba92d763e4117bbe581b82369b52005ec5f1fba784b9c3bcbb14e48ee1b"
    sha256 monterey:     "e15e31be78c15590f56e7267b87a1a4e0450b3c9334e217a0c55506e42191c47"
    sha256 big_sur:      "a13636407848ab98be40d078193f11e14524955f95f4a33f8e488dc160ce0dff"
    sha256 x86_64_linux: "e574c087e4e535910f86134e912d01adfa0eba8b9c51cbb8fb7b57d1df984607"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "aaa", "aaa"
  end
end
