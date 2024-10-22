class EsopipeCr2re < Formula
  desc "ESO CR2RES instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/cr2res/cr2re-kit-1.4.4.tar.gz"
  sha256 "bd4a4d1025ea98ed5372680f877c3b20521109600436c5621e876e994f6f6152"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?cr2re-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "esopipe-cr2re-recipes"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "cr2re-calib-#{version_norevision}.tar.gz"
    (prefix/"share/esopipes/datastatic/cr2re-#{version_norevision}").install Dir["cr2re-calib-#{version_norevision}/cal/*"]
  end

  test do
    system "true"
  end
end