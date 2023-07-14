class Esoreflex < Formula
  desc "Environment to automate data reduction workflows"
  homepage "https://www.eso.org/sci/software/esoreflex/"
  url "https://ftp.eso.org/pub/dfs/reflex/esoreflex-2.11.5.tar.gz"
  sha256 "65181046d00d00c1b66ce4e1493c430b7c2899b874f895d51f0dceaf34f1e1f6"
  license "GPL-2.0-or-later"

  depends_on "esorex"
  depends_on "java11"

  def install
    pkgshare.install Dir["*"]
    bin.install_symlink pkgshare/"esoreflex/bin/esoreflex"
    inreplace pkgshare/"esoreflex/bin/esoreflex" do |s|
      s.gsub! "$(dirname $0)/../..", HOMEBREW_PREFIX/"share/esoreflex"
      s.gsub! "~/KeplerData/workflows/MyWorkflows",
HOMEBREW_PREFIX/"share/reflex/workflows:~/KeplerData/workflows/MyWorkflows"
    end
    rm_rf pkgshare/"common/src"
  end

  test do
    system "true"
  end
end
