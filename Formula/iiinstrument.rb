class Iiinstrument < Formula
  desc "ESO example template instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/iiinstrument-kit-0.1.14-27.tar.gz"
  sha256 "8b281fab3de19c38dfac76e43c3f40b64be26e884d5883afbd051018b8983a9a"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/instruments/iiinstrument/"
    regex(/href=.*?iiinstrument-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/iiinstrument-0.1.14-27"
    sha256 cellar: :any,                 arm64_sonoma:  "ef780c1e67e3e55be7c636831a3df7f759e55c0002394c376abbf7902e6c1a0d"
    sha256 cellar: :any,                 arm64_ventura: "cd0540a25fd8d59ad1d51e22d73c162d3723bf42067b3b919551c92078a40838"
    sha256 cellar: :any,                 ventura:       "91412a391634ca3d5ecb464118e389bbfccadfeb66688522d1c3177445d662bd"
    sha256 cellar: :any,                 monterey:      "4223f918016b3cd90886a09563e5d46430832c02b83599414e4dd38f753689b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f599e4c868fc2e0bb4792942a7ff7a470f194df397b7cea956faaaed5aa79bec"
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
