# typed: strict
# frozen_string_literal: true

# Xshooter
class EsopipeXshooter < Formula
  desc "ESO XSHOOTER recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/xshooter/xshoo-kit-3.6.8.tar.gz"
  sha256 "e50f7172d65de8b8f54fc47a333d49a5fa6db34aabe097bbc1a3449f455ab2b9"
  license "GPL-2.0-or-later"
  revision 4

  livecheck do
    url :homepage
    regex(/href=.*?xshoo-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/alvaro-aguirre-cl/homebrew-esopipes/releases/download/esopipe-xshooter-3.6.8_4"
    sha256 cellar: :any,                 arm64_sonoma: "27b2475ae7dd56a50918f328b9c5aaa3827c6434c3c4e2690a83a8aeb15b28e8"
    sha256 cellar: :any,                 ventura:      "5386ddb2f27acb00113fc4eecf2c2af2dc2ea3b8a0a1e485b0a2c1f248d1e855"
    sha256 cellar: :any,                 monterey:     "1f8313995a05c7db7816346ebb4b8677793fb0a655cead3f5743933f87e4ce6d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9529373c1802eac9ad6d54853595a7dd9895240e8155ce8f3350eab395ea14f9"
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
    system "tar", "xf", "xshoo-#{version_norevision}.tar.gz"
    cd "xshoo-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cfitsio=#{Formula["cfitsio"].prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}",
             "--with-telluriccorr=#{Formula["telluriccorr"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "xsh_mdark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page xsh_mdark")
  end
end
