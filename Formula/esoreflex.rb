class Esoreflex < Formula
  desc "Reflex environment to execute ESO pipelines"
  homepage "https://www.eso.org/sci/software/esoreflex/"
  url "https://ftp.eso.org/pub/dfs/reflex/esoreflex-2.11.5.tar.gz"
  sha256 "65181046d00d00c1b66ce4e1493c430b7c2899b874f895d51f0dceaf34f1e1f6"
  license "GPL-2.0-or-later"

  depends_on "esorex"
  depends_on "openjdk@11"

  def install
    pkgshare.install Dir["*"]
    bin.install_symlink pkgshare/"esoreflex/bin/esoreflex"
    kepler_workflows = "~/KeplerData/workflows/MyWorkflows"

    inreplace pkgshare/"esoreflex/bin/esoreflex" do |s|
      s.gsub! "$(dirname $0)/../..", HOMEBREW_PREFIX/"share/esoreflex"
      s.gsub! kepler_workflows, HOMEBREW_PREFIX/"share/reflex/workflows:#{kepler_workflows}"
      s.gsub! "/etc/esoreflex.rc", HOMEBREW_PREFIX/"etc/esoreflex.rc"
      s.gsub! 'LOAD_ESOREX_CONFIG=""', "LOAD_ESOREX_CONFIG=#{HOMEBREW_PREFIX}/etc/esorex.rc"
    end

    rm_rf pkgshare/"common/src"
    rm_rf pkgshare/"ptolemy/src/vendors/fmusdk/src/shared/libexpatMT.lib"
    rm_rf pkgshare/"ptolemy/src/vendors/fmusdk/binaries/win32"
    rm_rf pkgshare/"ptolemy/src/ptolemy/actor/lib/fmi/fmus/win32"
    rm_rf pkgshare/"ptolemy/src/lib/libIncrementalFMU_wrap.jnilib"
    rm_rf pkgshare/"ptolemy/src/bin/macContents/Contents/MacOS/JavaApplicationStub"
    rm_rf pkgshare/"build-area/resources/installer/launch4j"
  end

  test do
    system "true"
  end
end
