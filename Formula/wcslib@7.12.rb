class WcslibAT712 < Formula
  desc "Library and utilities for the FITS World Coordinate System"
  homepage "https://www.atnf.csiro.au/people/mcalabre/WCS/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/wcslib/wcslib-7.12.tar.bz2"
  sha256 "9cf8de50e109a97fa04511d4111e8d14bd0a44077132acf73e6cf0029fe96bd4"
  license "GPL-3.0-or-later"
  revision 2

  livecheck do
    url :homepage
    regex(/href=.*?wcslib[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/wcslib@7.12-7.12_1"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma: "d1eed8ddf86522e3c420b865c15a539631569159665d91e8fe68f148eff0ac2c"
    sha256 cellar: :any,                 ventura:      "76373cf76de8c2a3d786f06089c1071e8ad68cffb1d3df05a26142777b724604"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a13b36b5c9dbc99dbb0435bb8381a028678e9d2b4881e14972fe10729aaca116"
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
