class Kmos < Formula
  desc "ESO KMOS recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/kmos/kmos-kit-4.4.4.tar.gz"
  sha256 "455b58e777335f59f31e7af56d77d64f54ea8a9f58dedae9851fbf75864de612"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?kmos-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/kmos-4.4.2-1"
    sha256 cellar: :any,                 arm64_sonoma: "7ee7cef487b85d7c5beaacaf462dabc1a1a4867ad0a3d98256cda0cf14ac9bec"
    sha256 cellar: :any,                 ventura:      "d594a83560f183f6e3e42b2b4e36d32ee67afe2cfa530b27ed6bd413f21e18fc"
    sha256 cellar: :any,                 monterey:     "87ed260164cce1649f62c7f4d3e1fc3b622d3594fc1cdc4f995b1f118de6587d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "32281b71aabbfa9a63ef78bed8e0d43812a9172c94a5a6e00f440c6b2116750f"
  end

  depends_on "cpl"
  depends_on "esorex"
  depends_on "pkg-config"
  depends_on "telluriccorr"

  def install
    system "tar", "xf", "kmos-4.4.2.tar.gz"
    cd "kmos-4.4.2" do
      # Fix -flat_namespace being used on Big Sur and later.
      system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      system "patch", "configure", "configure-big_sur.diff"
      system "./configure", "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-telluriccorr=#{Formula["telluriccorr"].prefix}"
      system "make", "install"
      rm_f bin/"kmos_calib.py"
      rm_f bin/"kmos_verify.py"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "kmos_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page kmos_dark")
  end
end
