class Esorex < Formula
  desc "Execution Tool for European Southern Observatory pipelines"
  homepage "https://www.eso.org/sci/software/cpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/esorex-3.13.8.tar.gz"
  sha256 "5c024203d94331a08720bee9ea63e2ffb12bb6cf76005e4c69df782ea1b3d890"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/esorex/"
    regex(/href=.*?esorex[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esorex-3.13.8"
    sha256 arm64_sonoma:  "576208a1698c10a1403417b06edd88c6996525ec8a3ef882ee92a6f2f464a500"
    sha256 arm64_ventura: "64a5fc489763d41abc17c6aa5e029994b11a7195d0c6fe842f6ddbdced6b50fd"
    sha256 ventura:       "9b600709fb0f13be339aec3b5b1df3e4c88c0f09672ba0dc2a012f7e8664dde7"
    sha256 monterey:      "5993beb4c64f98f5585ec84b91e1c3a9c76100e1b390eb6cb830c94ce2947203"
    sha256 x86_64_linux:  "7981eb86cca7ca54d48fd39f47a34288ad7e112bdb5026a66be06d23f420cbc2"
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
