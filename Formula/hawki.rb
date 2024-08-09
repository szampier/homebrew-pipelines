class Hawki < Formula
  desc "ESO HAWKI recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/hawki/hawki-kit-2.5.7.tar.gz"
  sha256 "c0c6920b1f098f63a8d33c50865bde75ddc0c6fd5c986acda226304f6041f13b"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?hawki-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/hawki-2.4.13-3_1"
    sha256 cellar: :any,                 arm64_sonoma:  "393d34dd667330a8d723391a02a690e518a5c9fc090219c73b2ecff4c481de27"
    sha256 cellar: :any,                 arm64_ventura: "8c10abba2038ceb6eb30258e455aa66b811c8eee167aea7dc8f740035109ecc2"
    sha256 cellar: :any,                 ventura:       "2c0d2c076d0524851c8ee32057c5b378e489f566d8f890bc6f98731ac17c22ae"
    sha256 cellar: :any,                 monterey:      "7f3a2701a35919d4a580c385d91ae7d5c72beb0e520f2db7ddc49f7ca40aa782"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f3617178d0537e3ef0abae3bd7e116fb2830472591b36223ffe1a297181445e2"
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
      system "curl", "-O", "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
      system "patch", "configure", "configure-big_sur.diff"
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
