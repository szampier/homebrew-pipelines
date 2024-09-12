class Hawki < Formula
  desc "ESO HAWKI recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/hawki/hawki-kit-2.5.8.tar.gz"
  sha256 "8c5640b1ea05d790ab708169c303fa43a143002b295a3b870c4300d49cd6ff5c"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?hawki-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/hawki-2.5.8"
    sha256 cellar: :any,                 arm64_sonoma: "70ef585587f4d4e8dc7c1ed07797a6f1a3aa0f26d44de654ea6cead12f437cda"
    sha256 cellar: :any,                 ventura:      "442a95a154540c1094ae58157a5a24f112c77e2801f0d4f1b32d6392221fb92a"
    sha256 cellar: :any,                 monterey:     "366d60e484ce42a60134c9e29aacabaf1ea060ab384179599b803bdba5d2a249"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7d13d9159effb5c0d5818fe7ec5d4c13f2ea0ea08d52f5e058f8d4216a7b9be9"
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
      # system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      # system "patch", "configure", "configure-big_sur.diff"
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
