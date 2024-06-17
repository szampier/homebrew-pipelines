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
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/uves-6.4.1-1_3"
    sha256 cellar: :any,                 arm64_sonoma:  "228d7e305028dd71291d71f137cdb2aab9d222503df8846c26bb4034020e7651"
    sha256 cellar: :any,                 arm64_ventura: "3d8fcc4ab9847d5f45bb4c701509577ab486829b9322f206d1043fe64b5c7bba"
    sha256 cellar: :any,                 ventura:       "ab238d59851f9f29eb0fa59dbeb38f39febcea1aa191e55c441456cc45c5f2c4"
    sha256 cellar: :any,                 monterey:      "3dff89df9e0720d8f90b40962b846466b235a3f8ca9cdd84e01f1a8c39178806"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3b8ca626ca563756073847b17dec3fb9a6c19c232ef1789a341f40fbd04af88a"
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
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "uves_cal_mbias -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page uves_cal_mbias")
  end
end
