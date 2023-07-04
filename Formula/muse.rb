class Muse < Formula
  desc "ESO MUSE recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/muse/muse-kit-2.8.9-1.tar.gz"
  sha256 "2884204f395813131ac11af63a19c03ec8747051286392c39d03f2d11bc94917"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?muse-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 ventura:      "d5ca0af396682e4b4a1c0ecbb7bd130269f17bd6f446899b2b12f8aaf518f3c7"
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
    system "tar", "xf", "muse-2.8.9.tar.gz"
    cd "muse-2.8.9" do
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
    system "esorex", "--man-page", "muse_bias"
  end
end
