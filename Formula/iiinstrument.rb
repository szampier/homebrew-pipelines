class Iiinstrument < Formula
  desc "ESO example template instrument pipeline (recipe plugins)"
  homepage "http://www.eso.org/sci/software/pipelines/"
  url "https://github.com/szampier/homebrew-pipelines/blob/main/src/iiinstrument-0.1.14.tar.gz?raw=true"
  sha256 "ba5fb3b4a515f899d3ccb3457af6fb76edc7121d390e27de42a23ae9e1a0bc29"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/iiinstrument-0.1.14.tar"
    rebuild 2
    sha256 ventura:      "e2f1dba92d763e4117bbe581b82369b52005ec5f1fba784b9c3bcbb14e48ee1b"
    sha256 monterey:     "e15e31be78c15590f56e7267b87a1a4e0450b3c9334e217a0c55506e42191c47"
    sha256 big_sur:      "a13636407848ab98be40d078193f11e14524955f95f4a33f8e488dc160ce0dff"
    sha256 x86_64_linux: "e574c087e4e535910f86134e912d01adfa0eba8b9c51cbb8fb7b57d1df984607"
  end

  depends_on "cpl"
  depends_on "gsl"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-cpl=#{Formula["cpl"].prefix}",
                          "--with-gsl=#{Formula["gsl"].prefix}"
    system "make", "install"
  end

  test do
    assert_equal "aaa", "aaa"
  end
end
