class EsopipeErisRecipes < Formula
  desc "ESO ERIS instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/eris/eris-kit-1.6.0.tar.gz"
  sha256 "00c5947cb3e7d7390a10b2c9e7865ce33c1aeb10f7562c01f6748f35c52b5822"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?eris-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "pkg-config" => :build
  depends_on "cfitsio@4.2.0"
  depends_on "cpl@7.3.2"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl@2.6"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "eris-#{version_norevision}.tar.gz"
    cd "eris-#{version_norevision}" do
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
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "eris_nix_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page eris_nix_dark")
  end
end
