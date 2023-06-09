class Esorex < Formula
  desc "Execution Tool for European Southern Observatory pipelines"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/esorex-3.13.7.tar.gz"
  sha256 "13cf719c5babbad3ee12d807676cd25df8bc84068b7f6f2179a56877ea7d47b4"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esorex-3.13.7"
    rebuild 2
    sha256 ventura:      "d073a43e9ace74b61ec6ab76991136424e0fe225ca5d141dc536000bb5034412"
    sha256 x86_64_linux: "78f16a3ccdbd5b06c0e29e27e64bf678904698075b3c05f610e4b807344182cc"
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
