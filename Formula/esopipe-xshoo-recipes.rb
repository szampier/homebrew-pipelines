class EsopipeXshooRecipes < Formula
  desc "ESO XSHOOTER instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/xshooter/xshoo-kit-3.6.8.tar.gz"
  sha256 "e50f7172d65de8b8f54fc47a333d49a5fa6db34aabe097bbc1a3449f455ab2b9"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?xshoo-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-xshooter-3.6.8"
    sha256 cellar: :any,                 arm64_sonoma:  "4ae7f4df122e404cc59927d50c38c456e15bfd582cd9fdd5eb256d74285ae2c3"
    sha256 cellar: :any,                 arm64_ventura: "ed26ae3ac56195915efa15df64fbab54db15c67cf836bec88fd06728892c8127"
    sha256 cellar: :any,                 ventura:       "7f837bd868d1fd3ab48a3b316401efcad66c28bf8d42c03a59ee99901745f296"
    sha256 cellar: :any,                 monterey:      "47a58bb9fafdbaee560f3c55ec32b8a38732cd83cbd6cb3b523e0f0ca7045666"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "42f06bda8ed221fa4456c5c884cf41675f63bc6faa879ef266aa33ea7e7f2226"
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
