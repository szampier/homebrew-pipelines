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
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/kmos-4.4.4"
    sha256 cellar: :any,                 arm64_sonoma:  "7bc43d4d04596e608d7a69789ecc0350049902f0875614a82ebf9dda32170c17"
    sha256 cellar: :any,                 arm64_ventura: "257cb07fbe4e9ed971ccc942763b159cdbdc5e32d879651dce5a581b13d4b439"
    sha256 cellar: :any,                 ventura:       "55e39da6c31a9f70b5e8e21f618b3cadb025f4739af6e69ab66b5b6cab308a69"
    sha256 cellar: :any,                 monterey:      "8fb903dd2f80040d1ad26dd4d84a798b7058cac3c01df4e3fcece03ebc83eca9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a32da7a1f7f94a129d48db8e5822fd02c9c11c0102e50f3235107ce098dd5abf"
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
      rm_f bin/"kmos_calib.py"
      rm_f bin/"kmos_verify.py"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "kmos_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page kmos_dark")
  end
end
