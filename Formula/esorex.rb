class Esorex < Formula
  desc "Execution Tool for European Southern Observatory pipelines"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/esorex-3.13.9.tar.gz"
  sha256 "609c484c7ac2c3b30cf6dbead25430b05c850f80aa140be3c85ffd104305ebc0"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/"
    regex(/href=.*?esorex[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esorex-3.13.9"
    sha256 arm64_sonoma:  "f968a7ec7fb7dad6a2d5f95ad6bec6706a6f879328ed898aa5946f3b996fdd44"
    sha256 arm64_ventura: "52a347cd9efe49f07586f0b1726cfbec0f832c52ce6185797f7b8e598ab7d320"
    sha256 ventura:       "4587938df73c6fab861accaec3f5f8162b25aba729ffe3c2c52f95335cf526e7"
    sha256 monterey:      "2173135b587470e36a3835cde8a2847a24d710c1794a451ac2c29ed23a1c0bce"
    sha256 x86_64_linux:  "e487541c1fc207f8e4bea9e11c87e85d9b09efbe185f3e0148b099f240adec22"
  end

  depends_on "cpl"
  depends_on "gsl"
  depends_on "libffi"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-cpl=#{Formula["cpl"].prefix}",
                          "--with-gsl=#{Formula["gsl"].prefix}",
                          "--with-libffi=#{Formula["libffi"].prefix}",
                          "--with-included-ltdl"
    system "make", "install"
    inreplace prefix/"etc/esorex.rc", prefix/"lib/esopipes-plugins", HOMEBREW_PREFIX/"lib/esopipes-plugins"
  end

  test do
    assert_match "ESO Recipe Execution Tool, version #{version}", shell_output("#{bin}/esorex --version")
  end
end
