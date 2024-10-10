class EsopipeErisRecipes < Formula
  desc "ESO ERIS instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/eris/eris-kit-1.6.0.tar.gz"
  sha256 "00c5947cb3e7d7390a10b2c9e7865ce33c1aeb10f7562c01f6748f35c52b5822"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?eris-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-eris-1.6.0"
    sha256 cellar: :any,                 arm64_sonoma: "29795fe905e9faa07b280eb9bb10370e79441ec4f3e5adbca82f60a50928d534"
    sha256 cellar: :any,                 ventura:      "b51f614e5e291631a1135cce8f44b6bf6f04ed5241821a8c9818708cdda7bf34"
    sha256 cellar: :any,                 monterey:     "c485b64ec91bb67967aa1f2fecfe11e7e2deaa06b1824b7731fdca44bad301cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f3bef90a89882321359e75b2198b922bae4a4a6885753ab0a1a6d58eb8b7978c"
  end

  depends_on "pkg-config" => :build
  depends_on "cfitsio"
  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "eris-#{version_norevision}.tar.gz"
    cd "eris-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cfitsio=#{Formula["cfitsio"].prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "eris_nix_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page eris_nix_dark")
  end
end
