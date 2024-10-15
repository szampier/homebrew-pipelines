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

  depends_on "esolib-cfitsio"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-cfitsiolib=#{Formula["esolib-cfitsio"].opt_lib}",
                          "--with-cfitsioinc=#{Formula["esolib-cfitsio"].opt_include}",
                          "--without-pgplot",
                          "--disable-fortran"
    system "make", "install"
  end

  test do
    piped = "SIMPLE  =" + (" "*20) + "T / comment" + (" "*40) + "END" + (" "*2797)
    pipe_output("#{bin}/fitshdr", piped, 0)
  end
end
