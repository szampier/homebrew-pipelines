class Telluriccorr < Formula
  desc "Telluric Correction"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/telluriccorr/telluriccorr-4.3.1.tar.gz"
  sha256 "a02dc7389588033efd22f71f0712f1b97d00cd732f701dee1b1e093dc062a64b"
  license "GPL-2.0-or-later"
  revision 2

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/telluriccorr-4.3.1_1"
    sha256 arm64_ventura: "28e60df88a6a05ef5b0db207eaa5e9cbfa52bcf9cfed1fd35dcab547f547df0a"
    sha256 ventura:       "23f17c1e309ada9a922979e732b4594547271f43bf792ed1031ac8c481a427d7"
    sha256 monterey:      "63d972a4d87ea12c03c944582eafede4ac36334cbe6e0437597d3fcb2401588d"
    sha256 x86_64_linux:  "ac02aac660bc5a405be4078288a66d1d3dacd1d2c93d3c04d39e56f68a6c2017"
  end

  depends_on "cpl"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--with-cpl=#{Formula["cpl"].prefix}"
    system "make", "install"
  end

  test do
    system "true"
  end
end
