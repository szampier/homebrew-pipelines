class EsopipeSpherRecipes < Formula
  desc "ESO SPHERE instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/sphere/spher-kit-0.56.0.tar.gz"
  sha256 "0c06cfa743b85fbf2980d0dbdb1bcf8cf57ea591e1f1cec987d6ca4abdc25157"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?spher-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-spher-recipes-0.56.0"
    sha256 cellar: :any,                 arm64_sonoma: "b1645b1e1f459457f84e1a32adcf531dd3a6d534ed3845a8a73df828b1d982b7"
    sha256 cellar: :any,                 ventura:      "91100dbf9c55a30d94c00204cc9d368d35be160c7a87ad056cb055f6385288c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e60d0e65079f37d4746483a10b49f8c63561052d4920f062527ebb9eb8653f40"
  end

  depends_on "pkg-config" => :build
  depends_on "cfitsio@4.2.0"
  depends_on "cpl@7.3.2"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl@2.6"

  def install
    ENV.prepend "LDFLAGS", "-L#{Formula["fftw@3.3.9"].opt_lib}"
    ENV.prepend "LDFLAGS", "-L#{Formula["wcslib@7.12"].opt_lib}"
    ENV.prepend "LDFLAGS", "-L#{Formula["cfitsio@4.2.0"].opt_lib}"

    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "spher-#{version_norevision}.tar.gz"
    cd "spher-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cfitsio=#{Formula["cfitsio@4.2.0"].prefix}",
             "--with-cpl=#{Formula["cpl@7.3.2"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}",
             "--with-gsl=#{Formula["gsl@2.6"].prefix}"
      system "make", "install"
    end
  end

  test do
    # version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "sph_zpl_master_dark -- version",
                 shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page sph_zpl_master_dark")
  end
end
