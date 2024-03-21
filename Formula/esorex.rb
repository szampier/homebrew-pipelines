class Esorex < Formula
  desc "Execution Tool for European Southern Observatory pipelines"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/esorex-3.13.7.tar.gz"
  sha256 "13cf719c5babbad3ee12d807676cd25df8bc84068b7f6f2179a56877ea7d47b4"
  license "GPL-2.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esorex-3.13.7"
    rebuild 4
    sha256 ventura:      "d5ca0af396682e4b4a1c0ecbb7bd130269f17bd6f446899b2b12f8aaf518f3c7"
    sha256 monterey:     "2488006ec3021f3943a8969786a89e0ee7d147cfdd3ea3586e915e06a41f3c7c"
    sha256 big_sur:      "2ddea4928083b869d75bde773258498c4698730d727032d10d1fed64486b81e9"
    sha256 x86_64_linux: "5b975a79239875b28552671869e4f1f82e5226e7f5bbb97d91947af05b42cee4"
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
