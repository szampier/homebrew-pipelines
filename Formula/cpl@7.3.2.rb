class CplAT732 < Formula
  desc "ISO-C libraries for developing astronomical data-reduction tasks"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/cpl/cpl-7.3.2.tar.gz"
  sha256 "a50c265a8630e61606567d153d3c70025aa958a28473a2411585b96894be7720"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/cpl/"
    regex(/href=.*?cpl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/cpl@7.3.2-7.3.2_1"
    sha256 cellar: :any,                 arm64_sonoma: "05c1a59beb61cbd4aec135153e7057385e61dc85c0701ce8d9690f2ad61f450d"
    sha256 cellar: :any,                 ventura:      "b02832897d5d3acccc6317a85f866bdeaa56cc7ae55af64fcc62c81c89253a4d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a9d815ed48e7d440e20e80169e4239d8b776d0853907efb62127d89dfa060fd2"
  end

  keg_only :versioned_formula

  depends_on "esolib-cfitsio"
  depends_on "esolib-fftw"
  depends_on "esolib-wcslib"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-cfitsio=#{Formula["esolib-cfitsio"].prefix}",
                          "--with-fftw=#{Formula["esolib-fftw"].prefix}",
                          "--with-wcslib=#{Formula["esolib-wcslib"].prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOF
      #include <cpl.h>
      int main(){
        cpl_init(CPL_INIT_DEFAULT);
        cpl_msg_info("hello()", "Hello, world!");
        cpl_end();
        return 0;
      }
    EOF
    system ENV.cc, "test.c", "-L#{lib}", "-I#{include}", "-lcplcore", "-lcext", "-o", "test"
    system "./test"
  end
end
