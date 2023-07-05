class Telluriccorr < Formula
  desc "Telluric Correction"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/telluriccorr/telluriccorr-4.3.1.tar.gz"
  sha256 "a02dc7389588033efd22f71f0712f1b97d00cd732f701dee1b1e093dc062a64b"
  license "GPL-2.0-or-later"

  bottle do
    sha256 cellar: :any,                 ventura:      "e7c7326683df4e360a8c3a492dbb7c6318cd6d98c6e8b14cf27942bc3bc951ad"
    sha256 cellar: :any,                 monterey:     "0cb11167c76aac6f71c5d9d0cdeaf81231bb9466a949b2596fb73812d5177299"
    sha256 cellar: :any,                 big_sur:      "3a8fe0eee8a22a291d1f0274ab5862e0527e26e1bf2a555174b739ad815b3aa8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b4de6da40d4e57adfdf9c1955ffd59cb10c619a406ff0a813e121ae3575e0e59"
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
