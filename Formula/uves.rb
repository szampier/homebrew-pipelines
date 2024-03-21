class Uves < Formula
  desc "ESO UVES recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/uves/uves-kit-6.4.1.tar.gz"
  sha256 "6914c994aa9170d5b2a05622f8beb8c3ef0014e18cd0408530765b7ec321a142"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?uves-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/uves-6.1.12-1"
    rebuild 1
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
    system "tar", "xf", "uves-6.4.1.tar.gz"
    cd "uves-6.4.1" do
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
    system "esorex", "--man-page", "uves_cal_mbias"
  end
end
