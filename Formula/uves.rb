class Uves < Formula
  desc "ESO UVES recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/uves/uves-kit-6.1.12-1.tar.gz"
  sha256 "9d77e6ac8e37110cf2f5289acebb682bbc583e1274e78f0a0b3f2c61bf1aec1c"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?uves-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 ventura:      "30a18fc0da532a36d2246c49fe86dbfde8e8a51ae1849970ba70b7588ea231e0"
    sha256 cellar: :any,                 monterey:     "7150f8de6020c63aaf246824925c4a6e8d32df11d7dbb9b417bb8ddb4554b0c3"
    sha256 cellar: :any,                 big_sur:      "8a168bb3fa40cf3bf0cd2c91d4e0cc50f46d44d5a0d730e4f57d2f7478fce321"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "35560a2607e679b5b03de4dfcbc826c9d42957b74a1fb3216617e47bbd42809a"
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    system "tar", "xf", "uves-6.1.12.tar.gz"
    cd "uves-6.1.12" do
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
