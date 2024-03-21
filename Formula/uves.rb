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
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/uves-6.4.1"
    sha256 cellar: :any,                 ventura:      "77eea197f6b67e00d0843dc602fa93ee4e3b07b10764b4feb865b9015d665a84"
    sha256 cellar: :any,                 monterey:     "344ec41b604ae22f24229e1b6653803c80519db6f9e010ec951f7389d319c4db"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8143dd6de0806442e937f866102ef0470e45637c87025e8f0251bb007d89ab6e"
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
