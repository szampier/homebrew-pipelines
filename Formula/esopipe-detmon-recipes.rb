# typed: strict
# frozen_string_literal: true

# Detmon
class EsopipeDetmonRecipes < Formula
  desc "ESO DETMON instrument pipeline (recipe plugins)"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/instruments/detmon/detmon-kit-1.3.14.tar.gz"
  sha256 "4d7ea0eb8e082d741ebd074c53165d2b7b1868582bde57ab715833efd17f69f3"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?detmon-kit-(\d+(?:[.-]\d+)+)\.t/i)
  end

  depends_on "pkg-config" => :build
  depends_on "curl"
  depends_on "erfa"
  depends_on "esolib-cpl"
  depends_on "esolib-gsl"
  depends_on "esorex"

  def install
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    system "tar", "xf", "detmon-#{version_norevision}.tar.gz"
    cd "detmon-#{version_norevision}" do
      system "./configure",
             "--prefix=#{prefix}",
             "--with-cpl=#{Formula["esolib-cpl"].prefix}",
             "--with-gsl=#{Formula["esolib-gsl"].prefix}",
             "--with-erfa=#{Formula["erfa"].prefix}",
             "--with-curl=#{Formula["curl"].prefix}"
      system "make", "install"
    end
  end

  test do
    version_norevision = version.to_s[/(\d+(?:[.]\d+)+)/i, 1]
    assert_match "detmon_opt_lg -- version #{version_norevision}", shell_output("#{HOMEBREW_PREFIX}/bin/esorex --man-page detmon_opt_lg")
  end
end
