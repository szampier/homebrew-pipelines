class EsopipeGravity < Formula
  desc "ESO GRAVITY recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/gravity/gravity-kit-1.6.6.tar.gz"
  sha256 "300be5f0b9907439485ee5c7aad784d93a1a679167e365a0eb3cd61ebc27b24d"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?gravity-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-gravity-1.6.6"
    sha256 cellar: :any,                 arm64_sonoma:  "b0707c3b8d47f3bff3abb3bc47a8ba832dc1ad6076746556ab1a030dcf08baca"
    sha256 cellar: :any,                 arm64_ventura: "11023d467d29bb046ad75fc8700c523c5abe6437e1bf5f3c331aa27b08700ac5"
    sha256 cellar: :any,                 ventura:       "927500327b73d97ac4d53190a3b47a14933f6d444d822fb725a7862f7d51afa0"
    sha256 cellar: :any,                 monterey:      "1de258ed99d3d661398b1b09895a3d76b5027afec8820c719a293923346b48bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a232ae9b18aec9944ef95ad39357ec8a06b83435c4c3399e281290546dc9c549"
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
      system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      system "patch", "configure", "configure-big_sur.diff"
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
