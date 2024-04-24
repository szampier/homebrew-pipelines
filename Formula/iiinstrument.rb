class Iiinstrument < Formula
  desc "ESO example template instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/iiinstrument-kit-0.1.14-50.tar.gz"
  sha256 "b08f398d81afce30edc968ce8b5361051d2f545c28e3ec4690c1648e3ee1f134"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/"
    regex(/href=.*?iiinstrument-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/iiinstrument-0.1.14-43"
    sha256 cellar: :any,                 arm64_sonoma:  "65ff7221ab34ce3a7c7ddddd25ef670d2020024c94913ad3a54095829782346b"
    sha256 cellar: :any,                 arm64_ventura: "785edf4909390e8675b43613087efc2b1209c9e6079fd15358326df1d1f97fbe"
    sha256 cellar: :any,                 ventura:       "aabea350363023b13f91385c4f50b975fa764075900ac3897d086865e664d794"
    sha256 cellar: :any,                 monterey:      "50fe42fcc1bfeae2f4d5c9da5a71f20249d6a4f305101807db6839697200499b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ea445a9c72fd62c8e9936744cdd5f76410bdfadb79d0bdfef86a7e9d5e6a96e6"
  end

  depends_on "cpl"
  depends_on "esorex"
  depends_on "gsl"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "iiinstrument-#{version_norevision}.tar.gz"
    cd "iiinstrument-#{version_norevision}" do
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
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "rrrecipe -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page rrrecipe")
  end
end
