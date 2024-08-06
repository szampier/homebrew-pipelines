class Muse < Formula
  desc "ESO MUSE recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/muse/muse-kit-2.10.10.tar.gz"
  sha256 "d3d51e755a0fdffc21d5730e0041f4e3a4826ec9ffcb97c1f0f69860a7a693df"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?muse-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/muse-2.8.9-2_1"
    sha256 cellar: :any,                 arm64_sonoma:  "13f29fad481f7a4c1e58b28046b84a676d25c5f0e1aff7d563f2726380a3af96"
    sha256 cellar: :any,                 arm64_ventura: "471938f8a0beeb7c1c6dcb0f7d9c75912752e267010094bee19f436778d9444d"
    sha256 cellar: :any,                 ventura:       "b190a0ff16636af22db756b563d05a6743f255e8b9482029f2499569c2673da9"
    sha256 cellar: :any,                 monterey:      "2a1f4be7ebe1ebcba558d3834e273be112831b7a3ba7e81450b3ac96b3871d47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f905ceea03d596b3b540e11ae7e8c8aeeb1cac76dc38e8a4c9cec934c0149f97"
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
