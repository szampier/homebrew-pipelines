class Espdr < Formula
  desc "ESO ESPRESSO recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/espresso/espdr-kit-3.1.0-1.tar.gz"
  sha256 "f11bc1b0e05d07b6681aff7779f43686538288ba0fefb16afb2fd8d01a91a015"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?espdr-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/espdr-3.0.0-12"
    sha256 ventura:      "475b8dd4c728baf7f5d211520ba35d6bb93d3543220e7262d19fbb57fc50869c"
    sha256 monterey:     "c711771c69a72303ed324a181b766ccaef847257e5020be045aa3ca41ffb4e96"
    sha256 big_sur:      "bf8da2def2e76f2455b496ca8b20117989b9eb92f3ccc71e125b7cbd24a94dbf"
    sha256 x86_64_linux: "47ab59be6d216959735b4792d1cc6a95c84e25f545d09250690457470b515b4f"
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    system "tar", "xf", "espdr-3.0.0.tar.gz"
    cd "espdr-3.0.0" do
      system "./configure", "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-gsl=#{Formula["gsl"].prefix}",
                            "--with-erfa=#{Formula["erfa"].prefix}",
                            "--with-curl=#{Formula["curl"].prefix}"
      system "make", "install"
    end
  end

  test do
    system "esorex", "--man-page", "espdr_mbias"
  end
end
