class GslAT26 < Formula
  desc "Numerical library for C and C++"
  homepage "https://www.gnu.org/software/gsl/"
  url "https://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz"
  mirror "https://ftpmirror.gnu.org/gsl/gsl-2.6.tar.gz"
  sha256 "b782339fc7a38fe17689cb39966c4d821236c28018b6593ddb6fd59ee40786a8"
  license "GPL-3.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/gsl@2.6-2.6"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma: "6c4da3be257a2779c094a0c691c844fb22fab23ef92bd1d723ca0aff09cc98c1"
    sha256 cellar: :any,                 ventura:      "d46385f079db921e762037d5e3f255eb5bae97e866a3406911731a88e516c20d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ba75026abbdd52766cefcb7bda7c1df947e1b65937d3a71d05a9853a9bf38319"
  end

  keg_only :versioned_formula

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
