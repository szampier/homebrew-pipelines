class Uves < Formula
  desc "ESO UVES recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/uves/uves-kit-6.4.6.tar.gz"
  sha256 "0d80c8cd55a271f2cb31549483ee139ac2e8054c759825d56bb605c41779a10a"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?uves-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/uves-6.4.6_1"
    sha256 cellar: :any,                 arm64_sonoma:  "ffa8d849d861e78c0524d1638ee291168f26e2a96b3f1a26ba638c9d347fb4c9"
    sha256 cellar: :any,                 arm64_ventura: "7b020c1e961096ee4676b4466df0a1aaee88454ebc19d5bdcf8887e360c21323"
    sha256 cellar: :any,                 ventura:       "ba8429d55caedbed862b2d55f0c1cffb2d9f9ba9e021c6841db097028aaba7d1"
    sha256 cellar: :any,                 monterey:      "6fdcb4f5393f3e74c523deb935eb7f8ca47212eff94e54e78a72eb28d5c560d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a8ed809b3c3ee6d785d248fd1e28f857038c31e423235b01b919c645975a6a65"
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
