class Espdr < Formula
  desc "ESO ESPRESSO recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/espresso/espdr-kit-3.2.0.tar.gz"
  sha256 "8d7d04a8434684a5e941e4d33a77eba5ce26e9c195e0d357c1ebc94944cf5a7a"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?espdr-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/espdr-3.1.0-1_1"
    sha256 arm64_sonoma:  "02f12a94287719fbca2bae52502893e4702311c0b148526e21c0123bac0daf54"
    sha256 arm64_ventura: "3243b3c85505526830d8e8b52facee9297d710a0b4c6d6575b99433eff572c8f"
    sha256 ventura:       "4977da38f7b853aab6629f36826b0d91cff749cc3d7235146b26e40d907bdc1e"
    sha256 monterey:      "bb685c58fab8f85ac3a80d950eb90940448f71730905978744f909c014663629"
    sha256 x86_64_linux:  "5797f685a9e757870cd5d3ffb54ae3fcc83b47ec92667a9701de3c4dcfe36209"
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    system "tar", "xf", "espdr-3.1.0.tar.gz"
    cd "espdr-3.1.0" do
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
