class EsopipeEspdrRecipes < Formula
  desc "ESO ESPRESSO instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/espresso/espdr-kit-3.2.0.tar.gz"
  sha256 "8d7d04a8434684a5e941e4d33a77eba5ce26e9c195e0d357c1ebc94944cf5a7a"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?espdr-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/espdr-3.2.0"
    sha256 arm64_sonoma:  "5c74a82d99aab260d16517fa93a2fb1786a16ff65be31d610ca77c19583ac7a4"
    sha256 arm64_ventura: "6aeb480d6bf8a34b797ac2365df32860f3fbceb3ee8c06bbd3315cbacbf1fbc2"
    sha256 ventura:       "d7333040c950bf2c9aab2dd03359b3a00c52fc0988b5da9ad23a75a6860cccec"
    sha256 monterey:      "5e1d23fa79e193b48cc1a7cc98c84ef64b31f7a77f8a41e933b422c9366f5bd2"
    sha256 x86_64_linux:  "9732d39b76cbb30bed874c7a12a5d8eaaac800645a53c75b02c585f3d852b97a"
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "espdr-#{version_norevision}.tar.gz"
    cd "espdr-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-gsl=#{Formula["gsl"].prefix}",
                            "--with-erfa=#{Formula["erfa"].prefix}",
                            "--with-curl=#{Formula["curl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "espdr_mbias -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page espdr_mbias")
  end
end
