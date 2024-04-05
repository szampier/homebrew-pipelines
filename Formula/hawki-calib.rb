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
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/hawki-calib-2.4.13-3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fd7c6b91b52d1ad3e365969bc24bc8bdb700e8b082782883745ab9a7be39e1bf"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a65423d740508bd4edcfa5ca16aba3e0997ea542627d4677bc0f171f1ad60969"
    sha256 cellar: :any_skip_relocation, ventura:       "3aa5ba289b780597b5480a484c7ba7332eac21fc2d3ccbb14fa527e92424d270"
    sha256 cellar: :any_skip_relocation, monterey:      "9a5147dca8cb626886eb356e872f38e1ae2148579e633b0a78a2cd201d5c7ca3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8eaf9d05e9dfabede04f97580ad1c3842cb2a36656fe95a123999114861dbcac"
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
