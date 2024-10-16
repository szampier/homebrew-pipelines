class CplAT732 < Formula
  desc "ISO-C libraries for developing astronomical data-reduction tasks"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/cpl/cpl-7.3.2.tar.gz"
  sha256 "a50c265a8630e61606567d153d3c70025aa958a28473a2411585b96894be7720"
  license "GPL-2.0-or-later"
  revision 2

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/cpl/"
    regex(/href=.*?cpl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/cpl@7.3.2-7.3.2_1"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma: "e155b1fe2ff1b117fc1b955c1e1d6c2c4ffc473371b0baa38efffc3c7eb025f9"
    sha256 cellar: :any,                 ventura:      "19e17c5d6d49a0a88002439f6b07eafb7e83536e31936fd7f530898346855e15"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "83d1f21ddc7a1d2a62386a61ff290f0e4fe8a290079f064e9cbb89d3811b2471"
  end

  keg_only :versioned_formula

  depends_on "cfitsio@4.2.0"
  depends_on "fftw@3.3.9"
  depends_on "wcslib@7.12"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-cfitsio=#{Formula["cfitsio@4.2.0"].prefix}",
                          "--with-fftw=#{Formula["fftw@3.3.9"].prefix}",
                          "--with-wcslib=#{Formula["wcslib@7.12"].prefix}"
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
