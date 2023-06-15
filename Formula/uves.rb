class Iiinstrument < Formula
  desc "ESO uves instrument pipeline (recipe plugins)"
  homepage "http://www.eso.org/sci/software/pipelines/"
  url "https://github.com/szampier/homebrew-pipelines/blob/main/src/uves-6.1.12.tar.gz?raw=true"
  sha256 "0e099894a5436c04b27e26079aebb6193876c1ad677c4f543107f72ef40704db"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/uves-6.1.12.tar"
    sha256 cellar: :any,                 ventura:      "1fe604a4d4526610a5d29cb9ffda082d4dfb03f04f150c3fc8e8273263d5a9a7"
    sha256 cellar: :any,                 monterey:     "54b8ee304c8b51ec68812e18a5ed111568f3e70f9ae1a1519e8a9244f2c9b59f"
    sha256 cellar: :any,                 big_sur:      "239684e1d8cf687d639e9c8e033ca629be39a0f4256fc4ade7800606cd7bad46"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "339a5d3d4e572ed6fb1f46f1001f77a2d79ee6b871f39f7faa63abe2ff2bff2b"
  end

  depends_on "cpl"
  depends_on "gsl"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-cpl=#{Formula["cpl"].prefix}",
                          "--with-gsl=#{Formula["gsl"].prefix}"
    system "make", "install"
  end

  test do
    assert_equal "aaa", "aaa"
  end
end
