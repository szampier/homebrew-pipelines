class Telluriccorr < Formula
  desc "Telluric Correction"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/telluriccorr/telluriccorr-4.3.1.tar.gz"
  sha256 "a02dc7389588033efd22f71f0712f1b97d00cd732f701dee1b1e093dc062a64b"
  license "GPL-2.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/telluriccorr-4.3.1"
    sha256 ventura:      "f229d1f1ec1c6e44f0d4c4d953405959450a9a906925382b94c348433d04fae1"
    sha256 monterey:     "002597a7681b3b55523e9e78ab6f1230cad832d7482c9f881e7f81bcfed944e1"
    sha256 big_sur:      "60de2cdd8378fc714b128bc1c28e575952ffe256002a2a6cb0b311acef7c5c29"
    sha256 x86_64_linux: "e1df03a214fc32e72064ad4bc1a1a1ba2aaff85332a65d9c83344db15effa7c0"
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
