class HawkiCalib < Formula
  desc "ESO HAWKI instrument pipeline (calibration data)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/hawki/hawki-kit-2.4.13-3.tar.gz"
  sha256 "a48297e56d216d566fb1bbb112d85243ba2a013c5ef9302c9dbe8745038d42e3"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?hawki-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/hawki-calib-2.4.14-3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8f7372fe0102611511a47702ba5d17080120fcf0d94149209ea93b590aeaacc3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5fd0e1f49fea1f96139693eab87e8664bcd5fde1b7550ff0fb37b19313904365"
    sha256 cellar: :any_skip_relocation, ventura:       "c928235f179c874e9b79ade88e3f143a7dc9b192a68168a6cd7c1e9589fe6aca"
    sha256 cellar: :any_skip_relocation, monterey:      "fd70b8ecd3229bdab9ac48f790137f3eaac7a948bf4a369499c9225d8a8288dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bd85b3cdbe697b6dbceb4e79bc29c4d52ae259c1c09f133d0cf8574ea3ad2aef"
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
