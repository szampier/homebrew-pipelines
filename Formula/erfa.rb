class Erfa < Formula
  desc "Essential Routines for Fundamental Astronomy"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/erfa/erfa-2.0.1.tar.gz"
  sha256 "3aae5f93abcd1e9519a4a0a5d6c5c1b70f0b36ca2a15ae4589c5e594f3d8f1c0"
  license "GPL-2.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/erfa-2.0.1"
    sha256 cellar: :any,                 arm64_ventura: "31fa6c7890a92a59e0e8ad7ea96476e27ee9d525b88562120b756fcab18ee8c9"
    sha256 cellar: :any,                 ventura:       "ab54f3e93cc2031859f5cef6f17e57b924172d5eb0f230bacab5ead2e3de8d49"
    sha256 cellar: :any,                 monterey:      "65f95a8c2447c909df1df6407728f541d0b536844729e4d0638a0002be18989d"
    sha256 cellar: :any,                 big_sur:       "f98257c997ce399715d8eb921ade287de24a152a240284c018d78b8bd44b8221"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e665cdf0b180d7d006783369151cdbb54311cbf9932a47bae28dc054a506d880"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "aaa", "aaa"
  end
end
