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
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/uves-calib-6.4.1-1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "43e4e25aa5c6b3e47ddbb8c2a1939d82893519cf9b6d53877674839e7b7fd00e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1ba8b68cb559f1c62cd436ae330e3d490690cef3a155b559fa1773482766b805"
    sha256 cellar: :any_skip_relocation, ventura:       "0f7710b7cd281efaca4dcae647e49d9d30a7d2199676ea3e94ce915349c0aff4"
    sha256 cellar: :any_skip_relocation, monterey:      "7e9f86cf3d948e4717152c62b533f0c1d2af8e6fcf829f4eeb496e2cbc4f9a0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d618621b4ec90b776d16246ecea0bc8c4a63280547b4cc0b71dae8cd4278223f"
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
