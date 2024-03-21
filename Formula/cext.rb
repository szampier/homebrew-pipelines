class Cext < Formula
  desc "ESO's C Library Extensions"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/cext/cext-1.2.6.tar.gz"
  sha256 "9dea2d70f2532c975fd0cfebc6e0b96ca8aa7703d39f482c6468991078821b0c"
  license "GPL-2.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/cext-1.2.6_1"
    sha256 cellar: :any,                 arm64_ventura: "a80d27476ee4e943e2d0c6d58b9e3efdfb15207ced55230d4b4b50b23032e42d"
    sha256 cellar: :any,                 ventura:       "9e99d65aa041fb148fd1aa7afda9a72e57c135faa923304d708c69d6c68f51d0"
    sha256 cellar: :any,                 monterey:      "b30e1a6a35794a3d95d705da7c65da6be6fe673db927494543baa1a72b26580f"
    sha256 cellar: :any,                 big_sur:       "119238b1b41cc05bb78bbd0f91e53536ff7cba52c6fd9f87fc8819f94a10b004"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "864dd3cef7c0650ceea0a02c2c67dcbd3f3ce3998fa47402ac59d82659a6e0da"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "aaa", "aaa"
  end
end
