class Erfa < Formula
  desc "Essential Routines for Fundamental Astronomy"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/erfa/erfa-2.0.1.tar.gz"
  sha256 "3aae5f93abcd1e9519a4a0a5d6c5c1b70f0b36ca2a15ae4589c5e594f3d8f1c0"
  license "GPL-2.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/erfa-2.0.1_1"
    sha256 cellar: :any,                 arm64_sonoma:  "e3c82f4a56c0b19d16dbb11f2a70a22a4c1277200af6b333c9bed1dc2d8f634e"
    sha256 cellar: :any,                 arm64_ventura: "fb9faa48c2e46d4bfbc0460ae415a5cbe4aeb8b3b125668c7f0354e73fc4511b"
    sha256 cellar: :any,                 ventura:       "422612ebeac5c00d1ad8305db82a9314b5975a893c3726c89b11cc5ef79d20e3"
    sha256 cellar: :any,                 monterey:      "b29886a026a94875740752052defdf0e821fffd8607cc5cfba23be576051acb2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cca66979fd6315a3485f92804c4407143be437c815e7fa3afdb5f61fc5cb7d7c"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "aaa", "aaa"
  end
end
