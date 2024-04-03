class Hawki < Formula
  desc "ESO HAWKI recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/hawki/hawki-kit-2.4.14-3.tar.gz"
  sha256 "eece5c219915e4d281c5e0516d0a15c880ba79f6d5940753766475f16bdd925a"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?hawki-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/hawki-2.4.14-3"
    sha256 cellar: :any,                 arm64_sonoma:  "bd6f92903fa4b9be779dc96322dcb2b0c39e258b1c69850ee5b217584a895d2b"
    sha256 cellar: :any,                 arm64_ventura: "46d5073256623b47f09603c321ad2e99356fb06ac47c2d262efbf5b3d72e2831"
    sha256 cellar: :any,                 ventura:       "910802e64197b0c2a1636e8ee48b3839b9e1f2a1ed70632a253fedaf0f7958d0"
    sha256 cellar: :any,                 monterey:      "8caac21a46b423110919e3ba1b5b6c8eaca349aa00d348ffc89cca40426834df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "530a6c37298e3d921aa7be715a48534f1ea30de654b496a0538eb9d184c9a70b"
  end

  depends_on "pkg-config" => :build
  depends_on "cpl"
  depends_on "esorex"
  depends_on "gsl"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "hawki-#{version_norevision}.tar.gz"
    cd "hawki-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "hawki_cal_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page hawki_cal_dark")
  end
end
