class Uves < Formula
  desc "ESO UVES recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/uves/uves-kit-6.4.1-1.tar.gz"
  sha256 "b801adb7ad804fe8b097fd29caaf04ebd3d61beaaabb902e2fa37330f471a4b1"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?uves-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/uves-6.4.1-1"
    sha256 cellar: :any,                 arm64_ventura: "999904598df0465068a43d095096e05243d61cdcdb3b040b961473cc45cc34e8"
    sha256 cellar: :any,                 ventura:       "946db12268e4c111ff39c74f28c888396ebd9073be84cd6b8b7826697c37d492"
    sha256 cellar: :any,                 monterey:      "e01b46ad432e758107d671bfc6b17dcbc51692800fb7d23f3750e70e4742c93e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bc2d5d9aeb7ee634be1b4f8ec45b91776d5b5f85eab0e5fa65b15eadea9b4c01"
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
