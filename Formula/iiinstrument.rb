class Iiinstrument < Formula
  desc "ESO example template instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/iiinstrument-kit-0.1.14-43.tar.gz"
  sha256 "12f31316ce76da8d0cb638899237bb638e078c93af2aaf334fb9068c462b8cd7"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/"
    regex(/href=.*?iiinstrument-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/iiinstrument-0.1.14-41"
    sha256 cellar: :any,                 arm64_sonoma:  "393d1317f70e972fa6bd81a4e75df2b1c2d9e23f46f079276085d032244141ba"
    sha256 cellar: :any,                 arm64_ventura: "6264d4c758d473e89921508a848aa25d7a16d2e84068d40794b4799ee716e075"
    sha256 cellar: :any,                 ventura:       "01540e85ab42a1ad9c5e27fa18aa30067c5d2a9b441cd6ba63d299f080d26485"
    sha256 cellar: :any,                 monterey:      "35f16cdc70f2fd54863a186226f5c36e521e82a754ecfea43b61c41ff9fe21d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6992cf15601f4f940693255ba89f40ce2f30a24d43a0c61ae0ee50d26613a58f"
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
