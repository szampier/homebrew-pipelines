class Esorex < Formula
  desc "Execution Tool for European Southern Observatory pipelines"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/esorex-3.13.8.tar.gz"
  sha256 "5c024203d94331a08720bee9ea63e2ffb12bb6cf76005e4c69df782ea1b3d890"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/"
    regex(/href=.*?esorex[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esorex-3.13.7_2"
    sha256 arm64_sonoma:  "5ff1675b9a795a74ea28cce93356687d864fe724fdfde71443829459aa74a77a"
    sha256 arm64_ventura: "0ce0acedc5f70f355dd796df361ba1c3a4adbb14d69a45439ad213032709c17f"
    sha256 ventura:       "f26c7d7811df613ec3c3140c5bcbc561b1995ecaa00e06abc4ea9a7bf92abfb7"
    sha256 monterey:      "c5f03c1571603af54cf1f9b5977dc8a39d860424a56f9f9897cd1e51c7c95c21"
    sha256 x86_64_linux:  "ff86aa076066a41a85dc3ec68ea23a4a954b095554d1b59aecb2a1e1525b2d24"
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
