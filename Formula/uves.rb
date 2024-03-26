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
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/uves-6.4.1-1_1"
    sha256 cellar: :any,                 arm64_sonoma:  "dfb2ad7e297a704600d739053fb7d1b987dffdf4cc85b0e397201ae279f57cd9"
    sha256 cellar: :any,                 arm64_ventura: "6e4a1488ee243a02772da43c5fc1da14d5fe82a905577ad563ce5e53bbe34764"
    sha256 cellar: :any,                 ventura:       "cfd747ced54df5b15cb349ab77ab3a476066d0af197f6067394960746a458d77"
    sha256 cellar: :any,                 monterey:      "c26874885d52959ec49d9b9dd3aa0d210aec5b31794c168a943127dc54370429"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db82a4c3a339633eb0b173ca01d6681c498e20dfc0fbd101bffa6f74dfd6ec0e"
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
    assert_match "uves_cal_mbias -- version #{version}", shell_output("#{bin}/esorex --man-page uves_cal_mbias")
  end
end
