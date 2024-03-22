class Cext < Formula
  desc "ESO's C Library Extensions"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/cext/cext-1.2.6.tar.gz"
  sha256 "9dea2d70f2532c975fd0cfebc6e0b96ca8aa7703d39f482c6468991078821b0c"
  license "GPL-2.0-or-later"
  revision 2

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/cext-1.2.6_2"
    sha256 cellar: :any,                 arm64_sonoma:  "40996fd48597ae06b2da85dc7e69bb8de9ddcb641200f0d1fc864a190469c269"
    sha256 cellar: :any,                 arm64_ventura: "dadfa501a94f601a83e7116c2e65549875edc8289b445e0f87bef97191366be4"
    sha256 cellar: :any,                 ventura:       "53bc84095425925d53e49d18c6b136c2ada6439d289ff264c153b7a772bb3e19"
    sha256 cellar: :any,                 monterey:      "d8d3527f0a376151aced9c2cfa9c095cc630fbed64e241d8af2234dc7f9d0ad1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "72f74466c616123a615b733574063d4b46481e949d10d7e5d25d3e5f0132d9c2"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "aaa", "aaa"
  end
end
