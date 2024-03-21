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
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/muse-2.8.9-2"
    sha256 cellar: :any,                 arm64_ventura: "3bba9e3bf91e52e14a0d3dda696f6bc99fa8c08da53424bd867d5902ac8c58db"
    sha256 cellar: :any,                 ventura:       "65a8cca101bdc35165e5e0241776b1eca6ba2218365e3af0dd7dbc15ff9f2846"
    sha256 cellar: :any,                 monterey:      "71493a96a73676e444cd5ae5b2c2884404936c2a9810c9eb61b8cd510831d7b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d315e40f66e30f7e7bfa4de66d7932235d8a2c1ba43b0151da7377b2589e935"
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
