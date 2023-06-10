class Esorex < Formula
  desc "Execution Tool for European Southern Observatory pipelines"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/esorex-3.13.7.tar.gz"
  sha256 "13cf719c5babbad3ee12d807676cd25df8bc84068b7f6f2179a56877ea7d47b4"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esorex-3.13.7"
    rebuild 3
    sha256 ventura:      "e2f1dba92d763e4117bbe581b82369b52005ec5f1fba784b9c3bcbb14e48ee1b"
    sha256 monterey:     "e15e31be78c15590f56e7267b87a1a4e0450b3c9334e217a0c55506e42191c47"
    sha256 big_sur:      "a13636407848ab98be40d078193f11e14524955f95f4a33f8e488dc160ce0dff"
    sha256 x86_64_linux: "e574c087e4e535910f86134e912d01adfa0eba8b9c51cbb8fb7b57d1df984607"
  end

  depends_on "cpl"
  depends_on "gsl"
  depends_on "libffi"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-cpl=#{Formula["cpl"].prefix}",
                          "--with-gsl=#{Formula["gsl"].prefix}",
                          "--with-libffi=#{Formula["libffi"].prefix}",
                          "--with-included-ltdl"
    system "make", "install"
  end

  test do
    assert_equal "aaa", "aaa"
  end
end
