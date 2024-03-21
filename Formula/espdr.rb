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
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/espdr-3.1.0-1"
    sha256 arm64_ventura: "79d34db95dcdd2066bc250619382b96b3bd10b69210930e6b5e3ccd3d781d9d1"
    sha256 ventura:       "edb5be100515aa84400b809a193dd82496785fcea9170d5ceb066404a5931b91"
    sha256 monterey:      "f798527a103c1a72e3effcdfc6be763c03c1943efd41840ea42acded6add2b40"
    sha256 x86_64_linux:  "7e1fdcb736a907d1ec7d005b2a5cb99b5da1ddab92e4cbffdc9a032c2bbed724"
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"

  def install
    system "tar", "xf", "espdr-3.1.0.tar.gz"
    cd "espdr-3.1.0" do
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
