# typed: strict
# frozen_string_literal: true

# Fors
class EsopipeFors < Formula
  desc "ESO FORS recipe plugins"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/fors/fors-kit-5.6.5-7.tar.gz"
  sha256 "e492be42ae3b96e48a2a3b2981feff8712fb2d616fd1f3f3f42ba243add2a15b"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?fors-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/esopipe-fors-5.6.5-7"
    sha256 arm64_sonoma:  "791898ddbbc127b7a2bb068d82f276709ce1b79fc7eb96e85c5a0f8cad5323f3"
    sha256 arm64_ventura: "8eaff368b76813eda0ab356da7be8f23db21ed071070353f6a648be472902db1"
    sha256 ventura:       "d9c28e2d8f029840fe3eaa4135b536ebc8f620dd7023089f5b4391692286f4fd"
    sha256 monterey:      "b3f6b1a52cda5c73e74f90690ba0a6cc8651a3290f8da57cb7bfff61e46cdbcb"
    sha256 x86_64_linux:  "75e520ba75a9482c558b2eaedd8af2ec06d105a48a012a72cefe7b7e388f3142"
  end

  depends_on "cfitsio"
  depends_on "cpl"
  depends_on "curl"
  depends_on "erfa"
  depends_on "esorex"
  depends_on "gsl"
  depends_on "pkg-config"
  depends_on "telluriccorr"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "fors-#{version_norevision}.tar.gz"
    cd "fors-#{version_norevision}" do
      system "./configure", "--prefix=#{prefix}",
             "--with-cfitsio=#{Formula["cfitsio"].prefix}",
             "--with-cpl=#{Formula["cpl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-telluriccorr=#{Formula["telluriccorr"].prefix}",
             "--with-gsl=#{Formula["gsl"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "fors_dark -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page fors_dark")
  end
end
