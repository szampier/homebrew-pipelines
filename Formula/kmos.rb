class Kmos < Formula
  desc "ESO KMOS recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/kmos/kmos-kit-4.4.2-1.tar.gz"
  sha256 "02fc0fc1a4b3db0a99ca47ddac5e4678d59d101def48c43be1bccf448e51befd"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?kmos-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/kmos-4.4.2-2"
    sha256 cellar: :any,                 ventura:      "5cc566087e8c5c8b999e2476d0e3746b628720fb02800252e1e0e13294890087"
    sha256 cellar: :any,                 monterey:     "8fc421b61809250e54780921002a96a5c8d766daf075231ca5ebe84979522a23"
    sha256 cellar: :any,                 big_sur:      "b27b69e6dba171d243105d457fccb00cdec0d6045300fc3d05bb6098760e65dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cf42b70821fbd65b86f279ba3beb0c7f8cfd28f54bd7e0668d67137562c572f9"
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
    system "esorex", "--man-page", "kmos_dark"
  end
end
