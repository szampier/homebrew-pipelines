class Pycpl < Formula
  desc "Python Language Bindings for CPL"
  homepage "https://www.eso.org/sci/software/pycpl/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/pycpl/pycpl-1.0.0.tar.gz"
  sha256 "aa9ee7e26d88a751494b9484542ea2285acbed3ff026821ff6bc54540aba3def"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url "https://ftp.eso.org/pub/dfs/pipelines/libraries/pycpl/"
    regex(/href=.*?pycpl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    root_url "https://github.com/szampier/homebrew-pipelines/releases/download/pycpl-1.0.0"
    sha256 cellar: :any,                 arm64_sonoma:  "32c469afe29e3420975e13b5f5ba7a88705301e18c7028895403a74b3af01886"
    sha256 cellar: :any,                 arm64_ventura: "2af9fa56c616cd4038e6ba487f4c41ed43d740d814f2b9e537b70dc2a64e2941"
    sha256 cellar: :any,                 ventura:       "7f611410313c21e9000508da6e4bc7aeab02431948f5f7b3d01d8bd4e4b60cc8"
    sha256 cellar: :any,                 monterey:      "85f860b3e779c8ae75619bc405e64e736962467c93b96fadd01e4dcce0a7dd11"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6a05db7acd4b85318f167283b74294cd4833ac7dc584c0805280cdc8038ddced"
  end

  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "cpl@7.3.2"
  depends_on "python@3.11"

  def install
    system "python", "-m", "pip", "install", *std_pip_args(build_isolation: true), "."
  end

  test do
    system "true"
  end
end
