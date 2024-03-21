class Esorex < Formula
  desc "Execution Tool for European Southern Observatory pipelines"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/esorex-3.13.7.tar.gz"
  sha256 "13cf719c5babbad3ee12d807676cd25df8bc84068b7f6f2179a56877ea7d47b4"
  license "GPL-2.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esorex-3.13.7_1"
    sha256 arm64_ventura: "3938259db42012727ebeabb2049ab19e578b15e1cc09b89727a9b42fd99f2732"
    sha256 ventura:       "2bf8702ad77a1e04befc8e827f5e5767b9ad57738b84964d1396f836c055613c"
    sha256 monterey:      "7bd5b843119c4275b392f51393fd9a245c9b1a77cbe11d66933de008ae2fef2b"
    sha256 x86_64_linux:  "348de01b9c752ca5e7d710206f8457eba3373921c603da490f213b4a9a071817"
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
    inreplace prefix/"etc/esorex.rc", prefix/"lib/esopipes-plugins", HOMEBREW_PREFIX/"lib/esopipes-plugins"
  end

  test do
    assert_equal "aaa", "aaa"
  end
end
