class EsopipeKmosRecipes < Formula
  desc "ESO KMOS instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/kmos/kmos-kit-4.4.4.tar.gz"
  sha256 "455b58e777335f59f31e7af56d77d64f54ea8a9f58dedae9851fbf75864de612"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?kmos-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-kmos-recipes-4.4.4"
    sha256 cellar: :any,                 arm64_sonoma: "2583d23d42658282a8329da92128c5ef3e924b7dd80ae9cedc148c0260ece301"
    sha256 cellar: :any,                 ventura:      "3341396035ca4ba42abdb7736a5d1245ee7957f74bdf67f643ec21b51018d335"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "641468cedca4d4045441514832db212f95b54db908ebe008d72a12009e0a9bd5"
  end

  depends_on "cpl"
  depends_on "esorex"
  depends_on "pkg-config"
  depends_on "telluriccorr"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "kmos-#{version_norevision}.tar.gz"
    cd "kmos-#{version_norevision}" do
      # Fix -flat_namespace being used on Big Sur and later.
      # system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      # system "patch", "configure", "configure-big_sur.diff"
      system "./configure", "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-telluriccorr=#{Formula["telluriccorr"].prefix}"
      system "make", "install"
      rm bin/"kmos_calib.py"
      rm bin/"kmos_verify.py"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "kmos_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page kmos_dark")
  end
end
