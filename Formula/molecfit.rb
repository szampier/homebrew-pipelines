class Molecfit < Formula
  desc "Correcting observations for telluric absorption"
  homepage "https://www.eso.org/sci/software/pipelines/skytools/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/molecfit_third_party/molecfit_third_party-1.9.2.tar"
  sha256 "da23be432e2497e75d6931adab7070880aff9ab26f17f8581cabc9cbec030193"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/molecfit_third_party/"
    regex(/href=.*?molecfit_third_party-(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 ventura:      "e7c7326683df4e360a8c3a492dbb7c6318cd6d98c6e8b14cf27942bc3bc951ad"
    sha256 cellar: :any,                 monterey:     "0cb11167c76aac6f71c5d9d0cdeaf81231bb9466a949b2596fb73812d5177299"
    sha256 cellar: :any,                 big_sur:      "3a8fe0eee8a22a291d1f0274ab5862e0527e26e1bf2a555174b739ad815b3aa8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b4de6da40d4e57adfdf9c1955ffd59cb10c619a406ff0a813e121ae3575e0e59"
  end

  depends_on "gcc"

  def install
    system "make", "-f", "BuildThirdParty.mk", "prefix=#{prefix}", "install"
  end

  test do
    system "true"
  end
end
