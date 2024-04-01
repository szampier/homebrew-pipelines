class Uves < Formula
  desc "ESO UVES recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/uves/uves-kit-6.4.1-1.tar.gz"
  sha256 "b801adb7ad804fe8b097fd29caaf04ebd3d61beaaabb902e2fa37330f471a4b1"
  license "GPL-2.0-or-later"
  revision 2

  livecheck do
    url :homepage
    regex(/href=.*?uves-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/uves-6.4.1-1_2"
    sha256 cellar: :any,                 arm64_sonoma:  "b19d406adda06fbf7d980896b30b615458f68b2d857371522f692a2bd29d3ee3"
    sha256 cellar: :any,                 arm64_ventura: "f59ee6c9d9060e86fe6e485053ed5b3a96d8749dbad88f903f001b230fa068fe"
    sha256 cellar: :any,                 ventura:       "0c72ece70abba434b3a0f2733451485622a2c758c5b79399d0c8181012b24617"
    sha256 cellar: :any,                 monterey:      "e5b628449b7478f87d5b72f094eee31d3717b0bff1dc46dff658696ebb3c38fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4fd509e262e7738db5cbc4e3660806e8e96e444dff16af472e928ebee589ce4"
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "uves-#{version_norevision}.tar.gz"
    cd "uves-#{version_norevision}" do
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
    system "tar", "xf", "uves-calib-#{version_norevision}.tar.gz"
    (prefix/"share/esopipes/datastatic/uves-#{version_norevision}").install Dir["uves-calib-#{version_norevision}/cal/*"]
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "uves_cal_mbias -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page uves_cal_mbias")
  end
end
