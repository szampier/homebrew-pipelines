class Uves < Formula
  desc "ESO UVES recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/uves/uves-kit-6.4.6.tar.gz"
  sha256 "0d80c8cd55a271f2cb31549483ee139ac2e8054c759825d56bb605c41779a10a"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?uves-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/uves-6.4.6"
    sha256 cellar: :any,                 arm64_sonoma:  "aa8b33fcd4b7403ae187a338afe2cb64df36df85690837eb52afe1a86a748978"
    sha256 cellar: :any,                 arm64_ventura: "91e80769e7c3abb1e69086e2f0c3158b2f08a3ae1cdb37e171c3a47c22b1786d"
    sha256 cellar: :any,                 ventura:       "a3099668ec5ec4522a021049c63d6f955ac8e59302a65ee0485883dfa9f4351a"
    sha256 cellar: :any,                 monterey:      "0d1efbb3dd6bc5d5cc4564388c7fefde72f1662bc6bf414a24f03ba312a3bf72"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6f23fa063694eb20cd4e3ca46cea7957bd190b066b6de2ed7334f071414cf588"
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"
  depends_on "uves-calib"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "uves-#{version_norevision}.tar.gz"
    cd "uves-#{version_norevision}" do
      # Fix -flat_namespace being used on Big Sur and later.
      # system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      # system "patch", "configure", "configure-big_sur.diff"
      system "./configure", "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-gsl=#{Formula["gsl"].prefix}",
                            "--with-erfa=#{Formula["erfa"].prefix}",
                            "--with-curl=#{Formula["curl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "uves_cal_mbias -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page uves_cal_mbias")
  end
end
