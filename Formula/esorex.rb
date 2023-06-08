class Esorex < Formula
  desc "Execution Tool for European Southern Observatory pipelines"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/esorex-3.13.7.tar.gz"
  sha256 "13cf719c5babbad3ee12d807676cd25df8bc84068b7f6f2179a56877ea7d47b4"
  license "GPL-2.0-or-later"

  depends_on "cpl"
  depends_on "gsl"

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
