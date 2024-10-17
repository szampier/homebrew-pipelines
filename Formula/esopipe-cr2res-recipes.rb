class EsopipeCr2resRecipes < Formula
  desc "ESO CR2RES instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/cr2res/cr2re-kit-1.4.4.tar.gz"
  sha256 "bd4a4d1025ea98ed5372680f877c3b20521109600436c5621e876e994f6f6152"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?cr2re-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-cr2res-recipes-1.4.4"
    sha256 cellar: :any,                 arm64_sonoma: "9b80e19b703ff5ea1bc81dbcc74d3e454f39fc8145b86ec110ac0389814f4f79"
    sha256 cellar: :any,                 ventura:      "07743ca58ac2cb766ef7baff3b5ed7aeb16df4ccf16ccd8306a320a4bcbe7ece"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f081b28a6d41ae778160e7b0a618b89bcf5399b17e56a345cdd97773a8dd32b8"
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
    system "tar", "xf", "cr2re-#{version_norevision}.tar.gz"
    cd "cr2re-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cfitsio=#{Formula["cfitsio@4.2.0"].prefix}",
             "--with-cpl=#{Formula["cpl@7.3.2"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}",
             "--with-gsl=#{Formula["gsl@2.6"].prefix}"
      system "make", "install"
    end
    rm_r bin
  end

  test do
    system "true"
  end
end
