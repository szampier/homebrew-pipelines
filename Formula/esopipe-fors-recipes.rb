class EsopipeForsRecipes < Formula
  desc "ESO FORS instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/fors/fors-kit-5.6.5-7.tar.gz"
  sha256 "e492be42ae3b96e48a2a3b2981feff8712fb2d616fd1f3f3f42ba243add2a15b"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?fors-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-fors-recipes-5.6.5-7"
    sha256 arm64_sonoma: "7536944581f861adbc37e696edeff48327f8e5e11fd6628debbcea7a1b96286c"
    sha256 ventura:      "187989ce924e71b8e6de0a611e52519243d0fc1af4b2a60131ea202449d70808"
    sha256 x86_64_linux: "75ab13f461cc8cb4296caf1f3aba8c915b90a272d25c39fb6f05b5f097b49572"
  end

  depends_on "cfitsio"
  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"
  depends_on "telluriccorr"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "fors-#{version_norevision}.tar.gz"
    cd "fors-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cfitsio=#{Formula["cfitsio"].prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-telluriccorr=#{Formula["telluriccorr"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "fors_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page fors_dark")
  end
end
