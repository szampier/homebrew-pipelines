class WcslibAT712 < Formula
  desc "Library and utilities for the FITS World Coordinate System"
  homepage "https://www.atnf.csiro.au/people/mcalabre/WCS/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/wcslib/wcslib-7.12.tar.bz2"
  sha256 "9cf8de50e109a97fa04511d4111e8d14bd0a44077132acf73e6cf0029fe96bd4"
  license "GPL-3.0-or-later"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?wcslib[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/wcslib@7.12-7.12_1"
    sha256 cellar: :any,                 arm64_sonoma: "7b34cb02810526dabc3fcbaca5ba0afe8a52e1f03fd185096f3a0f6dea9ecd8b"
    sha256 cellar: :any,                 ventura:      "c07fc5f0dee5e2d38bfe4aec079606e72d364557bce267c6680f712a9172ca38"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e2e809aad8329e6b694080576d5e1847fcdc18b3834cf6eae57ca2b189e36394"
  end

  depends_on "cfitsio@4.2.0"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-cfitsiolib=#{Formula["cfitsio@4.2.0"].opt_lib}",
                          "--with-cfitsioinc=#{Formula["cfitsio@4.2.0"].opt_include}",
                          "--without-pgplot",
                          "--disable-fortran"
    system "make", "install"
  end

  test do
    piped = "SIMPLE  =" + (" "*20) + "T / comment" + (" "*40) + "END" + (" "*2797)
    pipe_output("#{bin}/fitshdr", piped, 0)
  end
end
