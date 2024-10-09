class EsopipeHawkiRecipes < Formula
  desc "ESO HAWKI instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/hawki/hawki-kit-2.5.8.tar.gz"
  sha256 "8c5640b1ea05d790ab708169c303fa43a143002b295a3b870c4300d49cd6ff5c"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?hawki-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-hawki-recipes-2.5.8"
    sha256 cellar: :any,                 arm64_sonoma: "2326c1deec3fa8df3e0badcacfdb6ca66216cef9cb742cf260ba37cab8a04d74"
    sha256 cellar: :any,                 ventura:      "308119d370cf6725082dd14197645c12a30dc202c3571ca2660a755eeaba6dc0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ce0c28dd9faf1a8f824e707dcf748afbe620c78d82a6c64984c0d3a4850b13db"
  end

  depends_on "pkg-config" => :build
  depends_on "cpl"
  depends_on "esorex"
  depends_on "gsl"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "hawki-#{version_norevision}.tar.gz"
    cd "hawki-#{version_norevision}" do
      # Fix -flat_namespace being used on Big Sur and later.
      # system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      # system "patch", "configure", "configure-big_sur.diff"
      system "./configure", "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "hawki_cal_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page hawki_cal_dark")
  end
end
