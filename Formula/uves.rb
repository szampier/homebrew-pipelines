class Uves < Formula
  desc "ESO UVES recipe plugins"
  homepage "https://www.eso.org/public/"
  url "https://github.com/szampier/homebrew-pipelines/blob/main/src/uves-6.3.1.tar.gz?raw=true"
  sha256 "8a7086ab32d0ae7a134664c8f4c21b5dd48cf27fba69cd47be006b35e92efca7"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/uves-6.3.1.tar"
    sha256 cellar: :any,                 ventura:      "30a18fc0da532a36d2246c49fe86dbfde8e8a51ae1849970ba70b7588ea231e0"
    sha256 cellar: :any,                 monterey:     "7150f8de6020c63aaf246824925c4a6e8d32df11d7dbb9b417bb8ddb4554b0c3"
    sha256 cellar: :any,                 big_sur:      "8a168bb3fa40cf3bf0cd2c91d4e0cc50f46d44d5a0d730e4f57d2f7478fce321"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "35560a2607e679b5b03de4dfcbc826c9d42957b74a1fb3216617e47bbd42809a"
  end

  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "gsl"
  depends_on "pkg-config"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--with-cpl=#{Formula["cpl"].prefix}",
                          "--with-gsl=#{Formula["gsl"].prefix}",
                          "--with-erfa=#{Formula["erfa"].prefix}",
                          "--with-curl=#{Formula["curl"].prefix}"
    system "make", "install"
  end

  test do
    assert_equal "aaa", "aaa"
  end
end
