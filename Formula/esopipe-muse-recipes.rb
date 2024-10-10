class EsopipeMuseRecipes < Formula
  desc "ESO MUSE instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/muse/muse-kit-2.10.10.tar.gz"
  sha256 "d3d51e755a0fdffc21d5730e0041f4e3a4826ec9ffcb97c1f0f69860a7a693df"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?muse-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/muse-2.10.10"
    sha256 cellar: :any,                 arm64_sonoma:  "ddf8b661680a66e00d6a23a308e7c05a3c9804e9ae1c17bf4d4744aef8660f82"
    sha256 cellar: :any,                 arm64_ventura: "429fd2d0346949c8ea8645d0fbba9d9a78c3bca684cbc8236d428de4e5a6ddb6"
    sha256 cellar: :any,                 ventura:       "ad1488b38c7be4bbf95e1cb2e1016028aeeb155692ab3b4e8fe9d7338ed318a6"
    sha256 cellar: :any,                 monterey:      "ee30f7f41193c0dcb068c0df75d8537a3eba7d5940d836224863f5885f9d01e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de1e0cfebf0ccfd7a6fc3849712db5605e9ee52909eb2ab93ca1878e7aa35938"
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "muse-#{version_norevision}.tar.gz"
    cd "muse-#{version_norevision}" do
      # Fix -flat_namespace being used on Big Sur and later.
      # system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      # system "patch", "configure", "configure-big_sur.diff"
      system "./configure", "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-gsl=#{Formula["gsl"].prefix}",
                            "--with-erfa=#{Formula["erfa"].prefix}",
                            "--with-curl=#{Formula["curl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "muse_bias -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page muse_bias")
  end
end
