class Hawki < Formula
  desc "ESO HAWKI recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/hawki/hawki-kit-2.5.8.tar.gz"
  sha256 "8c5640b1ea05d790ab708169c303fa43a143002b295a3b870c4300d49cd6ff5c"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?hawki-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/hawki-2.5.7"
    sha256 cellar: :any,                 arm64_sonoma:  "66cc0dd97f25bb36c2ca487e1c4859de61206b89e3f5c1a20c08cd828e57ecdd"
    sha256 cellar: :any,                 arm64_ventura: "cb2e2cd12238ee4da97722fb4e9671144c3828335b360da3c4071b2187848b23"
    sha256 cellar: :any,                 ventura:       "807a0a4e9407e20bb8bb86978b868ad438bcc72463e339c1a25084bf3f33f0b9"
    sha256 cellar: :any,                 monterey:      "8fbb07e17d73552f4d3fc96629b44379cba63fc389c695172524184366bf5abf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7e9098e1f8cd3da21b4a9aaa82a679cad617645773c7d9d5bacd2a3b7bd28b60"
  end

  depends_on "pkg-config" => :build
  depends_on "cpl"
  depends_on "esorex"
  depends_on "gsl"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "hawki-#{version_norevision}.tar.gz"
    cd "hawki-#{version_norevision}" do
      # Fix -flat_namespace being used on Big Sur and later.
      # system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      # system "patch", "configure", "configure-big_sur.diff"
      system "./configure", "--prefix=#{prefix}",
                            "--with-cpl=#{Formula["cpl"].prefix}",
                            "--with-gsl=#{Formula["gsl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "hawki_cal_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page hawki_cal_dark")
  end
end
