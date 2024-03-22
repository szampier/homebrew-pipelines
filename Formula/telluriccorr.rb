class Telluriccorr < Formula
  desc "Telluric Correction"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/telluriccorr/telluriccorr-4.3.1.tar.gz"
  sha256 "a02dc7389588033efd22f71f0712f1b97d00cd732f701dee1b1e093dc062a64b"
  license "GPL-2.0-or-later"
  revision 2

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/telluriccorr-4.3.1_2"
    sha256 arm64_sonoma:  "0b239e9eec40ea079d2733c765d94449f0e061e14b0501dd073edf49a05fccf6"
    sha256 arm64_ventura: "07fc9b3b18ccb2de073210bdd3a5547d22e2265567fd9c98cbad2d00c65d35a9"
    sha256 ventura:       "f26ce0a5f864d0663ce71d0689d4f64090a831cf69cba72ef34b66c0d6ddd655"
    sha256 monterey:      "8dd68570f0efd1d4f7aaa8aa8bb2e3aace9d0387ecd81a719f31f0303dc9176a"
    sha256 x86_64_linux:  "e3b85db7485f588428bd854dd45cd3d7b066df723bc8dd8b2fe1eb63af5e915a"
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
