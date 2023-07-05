class Espdr < Formula
  desc "ESO ESPRESSO recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/espresso/espdr-kit-3.0.0-12.tar.gz"
  sha256 "83e4abf327f95f875af4ad0e650f7e22727508001d25b1f8fcb38b30b7df488e"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?espdr-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 ventura:      "a1451c4858bdc47ffc73ccebda98b39e031e811ea47dcc5e21b8b7deb8a946ae"
    sha256 cellar: :any,                 monterey:     "13ea703b82de3b7c5c3072ec6f52a5c0cc35b9f5809f368e23ebb6e678c6ee33"
    sha256 cellar: :any,                 big_sur:      "aa0123c648737ffbfee4156bfcc6cf5bb6519dee2c50e3e25eaf540e0fd52902"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "22f378c5e13a2951e8f0b53df5cbbcc4c9fb209410ed2c77311d57afec2df1b3"
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    system "tar", "xf", "espdr-3.0.0.tar.gz"
    cd "espdr-3.0.0" do
      # Fix -flat_namespace being used on Big Sur and later.
      system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      system "patch", "configure", "configure-big_sur.diff"
      system "./configure", "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-gsl=#{Formula["gsl"].prefix}",
                            "--with-erfa=#{Formula["erfa"].prefix}",
                            "--with-curl=#{Formula["curl"].prefix}"
      system "make", "install"
    end
  end

  test do
    system "esorex", "--man-page", "espdr_mbias"
  end
end
