class Kmos < Formula
  desc "ESO KMOS recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/kmos/kmos-kit-4.1.1-2.tar.gz"
  sha256 "51e67ccacf2b8f545e4942cf47033a69f5c4b6b71adfcfcd13a323b9e2701f6f"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?kmos-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/kmos-4.1.1-1"
    sha256 cellar: :any,                 ventura:      "a6d0d611c15bb949d786f453cd8a0e024ed1da7c686a4e87a542c4ef7a71c1bb"
    sha256 cellar: :any,                 monterey:     "1a2529401881b04b8dd4f46b7ca288dbda81db1812bbffba17559999dbce5e11"
    sha256 cellar: :any,                 big_sur:      "7e49ccf0a818d9fad91e846638071b349f00d3d7719a74774b32d7dbb6507759"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c82af37a9d43f328cf319b96ad5d17ecd0d027d9474152b1a534a255f3c8112d"
  end

  depends_on "cpl"
  depends_on "esorex"
  depends_on "pkg-config"
  depends_on "telluriccorr"

  def install
    system "tar", "xf", "kmos-4.1.1.tar.gz"
    cd "kmos-4.1.1" do
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
    system "esorex", "--man-page", "kmos_dark"
  end
end
