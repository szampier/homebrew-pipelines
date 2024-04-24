class Iiinstrument < Formula
  desc "ESO example template instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/iiinstrument-kit-0.1.14-50.tar.gz"
  sha256 "b08f398d81afce30edc968ce8b5361051d2f545c28e3ec4690c1648e3ee1f134"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/"
    regex(/href=.*?iiinstrument-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/iiinstrument-0.1.14-50"
    sha256 cellar: :any,                 arm64_sonoma:  "7b5ae1c672dd4fa4cad16bce4a13978af9aa4be9d4c0fc342a1ec828d2970101"
    sha256 cellar: :any,                 arm64_ventura: "6da2d6893e01f10cbc72d33b1858394c79c045b77793dec57377af19c0e3942b"
    sha256 cellar: :any,                 ventura:       "5ac1b162f31bfb42e31df4b6da05f5098ef5703bf2df2897c8d8e4b0bf5fc13f"
    sha256 cellar: :any,                 monterey:      "467581dcc44b00b5d8b0e7e4e6602a0c64e1bfb59aff2e4db18ceebdbafe552c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fda6599a7a88ba7526a2a07aa0ad3e052bd0daa699304cfc419851d6c7bc9c65"
  end

  depends_on "cpl"
  depends_on "esorex"
  depends_on "gsl"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "iiinstrument-#{version_norevision}.tar.gz"
    cd "iiinstrument-#{version_norevision}" do
      # Fix -flat_namespace being used on Big Sur and later.
      # system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      # system "patch", "configure", "configure-big_sur.diff"
      system "./configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "rrrecipe -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page rrrecipe")
  end
end
