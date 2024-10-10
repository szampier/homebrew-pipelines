class EsopipeGirafRecipes < Formula
  desc "ESO GIRAFFE instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/giraffe/giraf-kit-2.16.12.tar.gz"
  sha256 "6920f5a672fd2f8bb312180e922707707e747661e6767897bb229afa4da89a04"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?giraf-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-giraf-recipes-2.16.12"
    sha256 cellar: :any,                 arm64_sonoma: "8acab413a759cd87dcf941a2edeea3eceb1e10ec2858b59ac7f29c69da2e557d"
    sha256 cellar: :any,                 ventura:      "fd086dc27528325fc5bf572fe54b404da400bbe406f4cd826b080486e190b8e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c277353cca9510d45ec186f5088d3b2e70ac40c443d56956c744949848916cc8"
  end

  depends_on "pkg-config" => :build
  depends_on "cfitsio"
  depends_on "cpl"
  depends_on "esorex"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "giraf-#{version_norevision}.tar.gz"
    cd "giraf-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cfitsio=#{Formula["cfitsio"].prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "gimasterbias -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page gimasterbias")
  end
end
