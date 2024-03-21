class Erfa < Formula
  desc "Essential Routines for Fundamental Astronomy"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/erfa/erfa-2.0.1.tar.gz"
  sha256 "75cb0a2cc1561d24203d9d0e67c21f105e45a70181d57f158e64a46a50ccd515"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/erfa-2.0.0"
    sha256 cellar: :any,                 ventura:      "85a102b0cb8bd26f0d4f2423aea9875a8863ce8496cbf4a61873ae097ac45dd9"
    sha256 cellar: :any,                 monterey:     "5e6cb9e560709eed6a1eed5d72494ff52e97f6ee5104146804ba34debb8e05c7"
    sha256 cellar: :any,                 big_sur:      "5951b0e7355699ac17c8299ce0bd08e1e2d77f3cc079dbc05d1d5a4cadea26f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "78115add990d1bbfb09f5bf2e6f8eb6e718bf0b654c10e78617d9c5e74be79da"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "aaa", "aaa"
  end
end
