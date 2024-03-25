class Iiinstrument < Formula
  desc "ESO example template instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/iiinstrument-kit-0.1.14-23.tar.gz"
  sha256 "f3b1f23a47ac572265f90422b03ef3cda6e39fd313c1dfaecc85e4f673ef474e"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/"
    regex(/href=.*?iiinstrument-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/iiinstrument-0.1.14-23"
    sha256 cellar: :any,                 arm64_sonoma:  "08ba975d2a6ae3a4dd040ce94ea32c42abc0fc15b796e882c571b8f82f7a8f4f"
    sha256 cellar: :any,                 arm64_ventura: "a6342f6591da20f488f933fb544a746be7777904ff501f2b95e0cb52bbeca0d5"
    sha256 cellar: :any,                 ventura:       "560ab184079f615d04ec1c788aa2c65629807a2bf0a80b59db7665cdfc293c99"
    sha256 cellar: :any,                 monterey:      "4c57315890ebf84bec69503fef1be761ce9102a5f7f9a85da349517912de682b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1e79cf797c22186a38a4684b36b2d083aa63c39f4251f903de8d51493cab5c7d"
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
