class Hawki < Formula
  desc "ESO HAWKI recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/hawki/hawki-kit-2.4.13-3.tar.gz"
  sha256 "a48297e56d216d566fb1bbb112d85243ba2a013c5ef9302c9dbe8745038d42e3"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?hawki-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/hawki-2.4.13-3"
    sha256 cellar: :any,                 arm64_sonoma:  "61a7d37cc4a8d0a725536693a10807e0ddb543043fd139356284ec18d03dadc0"
    sha256 cellar: :any,                 arm64_ventura: "fe135d41b0a5d073aa0cc55aed68b2db09cd043b8715b64b01526857e2a71f59"
    sha256 cellar: :any,                 ventura:       "46031878806b19e829b79d024d88e44074d88e3880e7fbb5a769df96e980704d"
    sha256 cellar: :any,                 monterey:      "b5858e3fa920d269018017017ff0d36acf55322bca0c94173b78b0d6b8739ed2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "44ff7e10ce0ea71017ecd68c214d8e407becbd76e724b02021406bcfd533300d"
  end

  depends_on "pkg-config" => :build
  depends_on "cpl"
  depends_on "esorex"
  depends_on "gsl"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "hawki-#{version_norevision}.tar.gz"
    cd "hawki-#{version_norevision}" do
      # Fix -flat_namespace being used on Big Sur and later.
      system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      system "patch", "configure", "configure-big_sur.diff"
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
