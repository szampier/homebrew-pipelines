class HawkiCalib < Formula
  desc "ESO HAWKI instrument pipeline (calibration data)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/hawki/hawki-kit-2.5.7.tar.gz"
  sha256 "c0c6920b1f098f63a8d33c50865bde75ddc0c6fd5c986acda226304f6041f13b"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?hawki-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "hawki-calib-#{version_norevision}.tar.gz"
    (prefix/"share/esopipes/datastatic/hawki-#{version_norevision}").install Dir["hawki-calib-#{version_norevision}/cal/*"]
  end

  test do
    system "true"
  end
end
