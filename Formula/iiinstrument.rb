class Iiinstrument < Formula
  desc "ESO example template instrument pipeline (recipe plugins)"
  homepage "http://www.eso.org/sci/software/pipelines/"
  url "https://github.com/szampier/homebrew-pipelines/blob/main/src/iiinstrument-0.1.14.tar.gz?raw=true"
  sha256 "ba5fb3b4a515f899d3ccb3457af6fb76edc7121d390e27de42a23ae9e1a0bc29"
  license "GPL-2.0-or-later"

  bottle do
    sha256 ventura: "4e8f18f9d28564fd0d4339aae3284e4efd977dffd7bd9d3acc3b2274e9f3c377"
  end

  depends_on "cpl"
  depends_on "gsl"

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
