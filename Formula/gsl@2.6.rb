class GslAT26 < Formula
  desc "Numerical library for C and C++"
  homepage "https://www.gnu.org/software/gsl/"
  url "https://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz"
  mirror "https://ftpmirror.gnu.org/gsl/gsl-2.6.tar.gz"
  sha256 "b782339fc7a38fe17689cb39966c4d821236c28018b6593ddb6fd59ee40786a8"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/gsl@2.6-2.6"
    sha256 cellar: :any,                 arm64_sonoma: "d0aa3c43f5d49006cd5052a0ad75fe59a9709f4599e048a47d2f6b488a269940"
    sha256 cellar: :any,                 ventura:      "864516dfd6bbeac1718774344f37bd7fee8798ca68b56b8af68a559f62ee9297"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c48814999f65c1165bdfcb42e6cd561528a8f1ff39d19c9c09822073a919dfdb"
  end

  def install
    ENV.deparallelize
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make" # A GNU tool which doesn't support just make install! Shameful!
    system "make", "install"
  end

  test do
    system bin/"gsl-randist", "0", "20", "cauchy", "30"
  end
end
