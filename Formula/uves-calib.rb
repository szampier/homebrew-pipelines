class UvesCalib < Formula
  desc "ESO UVES instrument pipeline (calibration data)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/uves/uves-kit-6.4.6.tar.gz"
  sha256 "0d80c8cd55a271f2cb31549483ee139ac2e8054c759825d56bb605c41779a10a"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?uves-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/uves-calib-6.4.6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8d3579d6b1cb9eb95848dd608365e71f736002689e65d4e855024e5fc07e6f20"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e8ee405a7bb669da2cec5470ce810849eff07a738482915d791652178b17f728"
    sha256 cellar: :any_skip_relocation, ventura:       "b2b5780949e55f6d1e538f162f1bd5a4233bb6f0bcd0d7bb03cbf66ae4879def"
    sha256 cellar: :any_skip_relocation, monterey:      "1463d693b2f3ef182952e0c9d034648f9e8996a64c0601db6e5090ab884e0900"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b98762ebd37d5d9b14d63a286517b4f52e8d1c93b5ea817dad5d16743cc183e"
  end

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "uves-calib-#{version_norevision}.tar.gz"
    (prefix/"share/esopipes/datastatic/uves-#{version_norevision}").install Dir["uves-calib-#{version_norevision}/cal/*"]
  end

  test do
    system "true"
  end
end
