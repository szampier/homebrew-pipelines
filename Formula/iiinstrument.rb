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
    sha256 cellar: :any,                 ventura:      "1fe604a4d4526610a5d29cb9ffda082d4dfb03f04f150c3fc8e8273263d5a9a7"
    sha256 cellar: :any,                 monterey:     "54b8ee304c8b51ec68812e18a5ed111568f3e70f9ae1a1519e8a9244f2c9b59f"
    sha256 cellar: :any,                 big_sur:      "239684e1d8cf687d639e9c8e033ca629be39a0f4256fc4ade7800606cd7bad46"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "339a5d3d4e572ed6fb1f46f1001f77a2d79ee6b871f39f7faa63abe2ff2bff2b"
  end

  depends_on "cpl"
  depends_on "esorex"
  depends_on "gsl"

  def install
    system "tar", "xf", "iiinstrument-0.1.14.tar.gz"
    cd "iiinstrument-0.1.14" do
      # Fix -flat_namespace being used on Big Sur and later.
      system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      system "patch", "configure", "configure-big_sur.diff"
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
