class EsopipeEsotkRecipes < Formula
  desc "ESO ESOTK instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/esotk/esotk-kit-0.9.7-1.tar.gz"
  sha256 "2d2db2d352b146b1f7c683cd1ee107bb5275e597ef412474ac4d39163fb6ce36"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?esotk-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-esotk-recipes-0.9.7-1"
    sha256 cellar: :any,                 arm64_sonoma: "b177eae040dd7eabe84ada530585d293791ccee34331aa85b5de9cfcdb83598d"
    sha256 cellar: :any,                 ventura:      "f4c018054ab4d456b88a49c8db66a68f9aeb321ec9e2e6c9b26d66214c26b507"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eecf2e2f050a57cf81e888269cc7b3bccad49fe557c5bee3c46e5bbcdf6a69a3"
  end

  depends_on "pkg-config" => :build
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
    system "tar", "xf", "esotk-#{version_norevision}.tar.gz"
    cd "esotk-#{version_norevision}" do
      system "./configure",
             "--prefix=#{prefix}",
             "--with-cpl=#{Formula["cpl@7.3.2"].prefix}",
             "--with-gsl=#{Formula["gsl@2.6"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "esotk_spectrum1d_combine -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page esotk_spectrum1d_combine")
  end
end
