class Cext < Formula
  desc "ESO's C Library Extensions"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/cext/cext-1.2.6.tar.gz"
  sha256 "9dea2d70f2532c975fd0cfebc6e0b96ca8aa7703d39f482c6468991078821b0c"
  license "GPL-2.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/cext-1.2.6"
    sha256 cellar: :any,                 ventura:      "e7c7326683df4e360a8c3a492dbb7c6318cd6d98c6e8b14cf27942bc3bc951ad"
    sha256 cellar: :any,                 monterey:     "0cb11167c76aac6f71c5d9d0cdeaf81231bb9466a949b2596fb73812d5177299"
    sha256 cellar: :any,                 big_sur:      "3a8fe0eee8a22a291d1f0274ab5862e0527e26e1bf2a555174b739ad815b3aa8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b4de6da40d4e57adfdf9c1955ffd59cb10c619a406ff0a813e121ae3575e0e59"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "aaa", "aaa"
  end
end
