class EsopipeGravity < Formula
  desc "ESO GRAVITY recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/gravity/gravity-kit-1.6.7-2.tar.gz"
  sha256 "1eafb832c91df9ea05b4758d0b250c30d7b57a6d0ff5103d9aac25fe778d9c1e"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?gravity-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-gravity-1.6.7-2"
    sha256 cellar: :any,                 arm64_sonoma:  "6e2d7a28581ac5a1a35aadbc07bd4fd5228e42a1ca06c4ea6a2964d8fb8658c0"
    sha256 cellar: :any,                 arm64_ventura: "4586fbc3467b325fbef0b605d450d135875af1186d43e48cd58ba524261aff61"
    sha256 cellar: :any,                 ventura:       "a4be0b2ca7e5dd5643ede818a605fab2d14e741029b39db57685797a565fbefb"
    sha256 cellar: :any,                 monterey:      "9d7a86d7fe5a35fc7da6a52fd78adbaf012d0fc6ceec6571d01ad2ae760518f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cb03bb5c2ff7959e5ec86583e4010bc684390bfca147ca13d0af4b980402c1ba"
  end

  depends_on "pkg-config" => :build
  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "gravity-#{version_norevision}.tar.gz"
    cd "gravity-#{version_norevision}" do
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
    assert_match "gravity_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page gravity_dark")
  end
end
