class Iiinstrument < Formula
  desc "ESO example template instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/iiinstrument-kit-0.1.14-23.tar.gz"
  sha256 "03eddcb36174615e43d0f6733b6fce30ce1507bfe2da3e091b7fe12410ecf692"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/"
    regex(/href=.*?iiinstrument-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/iiinstrument-0.1.14-23"
    sha256 cellar: :any,                 arm64_ventura: "c1053986816210ac4922d32ed4de77588b526b6b1f45c3470e1dc1db3857f6e0"
    sha256 cellar: :any,                 ventura:       "55047c558607e840d29a871c8f386d44a7f2703a7c4b74eb21efb4234298300d"
    sha256 cellar: :any,                 monterey:      "812b3e5865f36e4889b1325c982dbacb41f6ec4ebe1736bdefc662001aac102c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4b49db416a4b215b69cb0f2198656bf71177b8175b2722bf579ae2d578526a8"
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
