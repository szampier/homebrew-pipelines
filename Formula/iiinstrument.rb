class Iiinstrument < Formula
  desc "ESO example template instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/iiinstrument-kit-0.1.14-16.tar.gz"
  sha256 "e772d85219e3e827cd386cd4ef2e96da689d72178428fb875e8e19b33a4f5e95"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/"
    regex(/href=.*?iiinstrument-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/iiinstrument-0.1.14-16"
    sha256 cellar: :any,                 ventura:      "f6a72a852a8b1ce76c04e0ff2cfab661ec339f578f1296936fa6d9c5238c3844"
    sha256 cellar: :any,                 monterey:     "c14369881af7326b264758b2f229684c47321a0fdcbbaeaf575b566fb305a7ee"
    sha256 cellar: :any,                 big_sur:      "3d191498ad6bdd734f97e375cf93635159aa7329122af9af31fdf166e7c1b026"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0b1ec8a50756da676a3adc819c4cdd3224b58816ef48bca953e6423e4d608492"
  end

  depends_on "cpl"
  depends_on "esorex"
  depends_on "gsl"

  def install
    system "tar", "xf", "iiinstrument-0.1.14.tar.gz"
    cd "iiinstrument-0.1.14" do
      # Fix -flat_namespace being used on Big Sur and later.
      # system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      # system "patch", "configure", "configure-big_sur.diff"
      system "./configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    system "esorex", "--man-page", "rrrecipe"
  end
end
