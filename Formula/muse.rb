class Muse < Formula
  desc "ESO MUSE recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/muse/muse-kit-2.8.9-2.tar.gz"
  sha256 "2a95fe6b90b9829218f295d2d73daa14691d00618679d904f83fac25f8e5948d"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?muse-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/muse-2.8.9-1"
    rebuild 1
    sha256 cellar: :any,                 ventura:      "7a7ed36776753d632fcdfb0dce07cc189fc9ccda0ee42a6ea17ed1504efbdcdb"
    sha256 cellar: :any,                 monterey:     "7ac3b45445dee5828c7f477e367fa4e1c8fee1a7f0463e0faff26547c6e460eb"
    sha256 cellar: :any,                 big_sur:      "cc13a9953c37c59578219976022067984de8f3926da54e143f1830d9439d52f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b5e9dc8a57f543d673f1d8dc0a3697da8d50ac7944220fc7d9accd52078af7da"
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
