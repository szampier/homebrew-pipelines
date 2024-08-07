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
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-gravity-1.6.6_1"
    sha256 cellar: :any,                 arm64_sonoma:  "49b56f6e50ef3ab441e552fc23ccdcf3dc1db6e30b166697a0b7a034f7fbc7cd"
    sha256 cellar: :any,                 arm64_ventura: "c495fc6cc29ae7756597b6af08d3347dffeb6b170a79cfde97d0848229a8fc81"
    sha256 cellar: :any,                 ventura:       "5f30776f496cbf16f72601bfa83a463a41fef7a743c9cfa8c1224497d2d5144b"
    sha256 cellar: :any,                 monterey:      "007cfae15c3cc3bcf9bfd9429537f6fda98e7b37d0edc948593c004c4f8de808"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5cf9d6275dc9af225212a41c459a6fa31e2e64606f12801638c13ae121bd0821"
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
