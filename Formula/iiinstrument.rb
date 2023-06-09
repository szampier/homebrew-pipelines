class Iiinstrument < Formula
  desc "ESO example template instrument pipeline (recipe plugins)"
  homepage "http://www.eso.org/sci/software/pipelines/"
  url "https://github.com/szampier/homebrew-pipelines/blob/main/src/iiinstrument-0.1.14.tar.gz?raw=true"
  sha256 "ba5fb3b4a515f899d3ccb3457af6fb76edc7121d390e27de42a23ae9e1a0bc29"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/iiinstrument-0.1.14.tar"
    rebuild 2
    sha256 cellar: :any,                 ventura:      "96915355cb559d7c15f696e111bd3a8f1c7fdeb17ab5ec166527ad37e54ecdfb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6280e4e98fd49746b2995b526e1af06cc91de98136a6fae5ee57de23278e2877"
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
