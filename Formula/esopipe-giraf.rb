class EsopipeGiraf < Formula
  desc "ESO GIRAFFE recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/giraffe/giraf-kit-2.16.12.tar.gz"
  sha256 "6920f5a672fd2f8bb312180e922707707e747661e6767897bb229afa4da89a04"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?giraf-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-giraf-2.16.12"
    sha256 cellar: :any,                 arm64_sonoma: "9d6e68cf137569710e29495ca066165456684cc1208cba426f83796e53862ade"
    sha256 cellar: :any,                 ventura:      "26675b96b5bb93fb9b529050cd758d9143fb51adbcd1a9d74c8f560dfb47eade"
    sha256 cellar: :any,                 monterey:     "517ef011d5eee69ee00993ab1ca0167235a7ac621d1f400678bc02687a4bbedb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "306fe339a744a690238bb8c5101766beb8c334f82da0fd3ddc9070c717da4c13"
  end

  depends_on "pkg-config" => :build
  depends_on "cfitsio"
  depends_on "cpl"
  depends_on "esorex"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "giraf-#{version_norevision}.tar.gz"
    cd "giraf-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cfitsio=#{Formula["cfitsio"].prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "gimasterbias -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page gimasterbias")
  end
end
