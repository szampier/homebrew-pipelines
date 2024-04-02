class EspdrCalib < Formula
  desc "ESO ESPRESSO instrument pipeline (calibration data)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/espresso/espdr-kit-3.1.0-1.tar.gz"
  sha256 "f11bc1b0e05d07b6681aff7779f43686538288ba0fefb16afb2fd8d01a91a015"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?espdr-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/espdr-calib-3.1.0-1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d0871059ad72ced8cbb482d2344d651a287589f766dc0cec349fa1ce4fdf4952"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b94de03b79dc5383862865092555877f7341f00303036e3d00bd4b958a066812"
    sha256 cellar: :any_skip_relocation, ventura:       "38828f8be4ea6941cdd79d99cde38a9030aa6f512baa260065e3fb2009c6e747"
    sha256 cellar: :any_skip_relocation, monterey:      "d9e7deb650112fa1e41102fde0e7d13781502a195ef62525829c37c7e639ea29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "10d21ec7cb8ce0c704223d4f2ae7398af29c35c48884517e4ae97d6faa6ac5a9"
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
