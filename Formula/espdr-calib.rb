class EspdrCalib < Formula
  desc "ESO ESPRESSO instrument pipeline (calibration data)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/espresso/espdr-kit-3.2.0.tar.gz"
  sha256 "8d7d04a8434684a5e941e4d33a77eba5ce26e9c195e0d357c1ebc94944cf5a7a"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?espdr-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/espdr-calib-3.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d693abd5441909be3f99dce93bf17012e1681e56f5c491c087d985ebe9d5189f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "db3bdf4796f440fda4eb2bf0305785e7d673fe1384ad572f5720b6d8362aac7d"
    sha256 cellar: :any_skip_relocation, ventura:       "40f4984b9f41982d8ab80d9c30d41f0ef8cea982a2093ce8afd0d158a003d820"
    sha256 cellar: :any_skip_relocation, monterey:      "d40c6d142b57dcfb4af5fbc49e32a9f520d9fb5a1751c3a548ebefa80777fc01"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "055b3cd876b52695f61cbfcc73465e77ab2b3b5926750b1c2a10792c39625044"
  end

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "espdr-calib-#{version_norevision}.tar.gz"
    (prefix/"share/esopipes/datastatic/espdr-#{version_norevision}").install Dir["espdr-calib-#{version_norevision}/cal/*"]
  end

  test do
    system "true"
  end
end
