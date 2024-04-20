class Esoreflex < Formula
  desc "Reflex environment to execute ESO pipelines"
  homepage "https://www.eso.org/sci/software/esoreflex/"
  url "https://ftp.eso.org/pub/dfs/reflex/esoreflex-2.11.5.tar.gz"
  sha256 "65181046d00d00c1b66ce4e1493c430b7c2899b874f895d51f0dceaf34f1e1f6"
  license "GPL-2.0-or-later"

  depends_on "esorex"
  depends_on "openjdk@11"
  depends_on "python@3.9"

  def install
    pkgshare.install Dir["*"]
    bin.install_symlink pkgshare/"esoreflex/bin/esoreflex"
    kepler_workflows = "~/KeplerData/workflows/MyWorkflows"
    esoreflex_default_recipe_config = "#{etc}/esoreflex_default_recipe_config.rc"

    cp "#{Formula["cpl"].etc}/esorex.rc", "#{etc}/esoreflex-esorex.rc"

    (etc/"esoreflex_default_recipe_config.rc").write <<~EOS
      # No default parameters should be specified for recipes under Reflex.
    EOS

    (etc/"esoreflex.rc").write <<~EOS
      # This is the system wide configuration file for esoreflex #{version}.
      # One can copy this file to ~/.esoreflex/esoreflex.rc and adjust these
      # parameters appropriately for your customised environment if needed.
      # However, if you do modify this file or use it with a different esoreflex
      # version, it is possible it may not work properly. You will have to know what
      # you are doing.

      # TRUE/FALSE indicating if the user's environment should be inherited.
      esoreflex.inherit-environment=FALSE

      # The binary or command used to start Java.
      esoreflex.java-command=#{Formula["openjdk@11"].bin}/java

      # The search paths for workflows used by the launch script.
      esoreflex.workflow-path=#{HOMEBREW_PREFIX}/share/reflex/workflows:~/KeplerData/workflows/MyWorkflows

      # The command used to launch esorex.
      esoreflex.esorex-command=esorex

      # The path to the esorex configuration file.
      esoreflex.esorex-config=#{HOMEBREW_PREFIX}/etc/esoreflex-esorex.rc

      # The path to the dummy configuration file for recipes.
      esoreflex.esorex-recipe-config=#{HOMEBREW_PREFIX}/etc/esoreflex_default_recipe_config.rc

      # The command used to launch python.
      esoreflex.python-command=#{HOMEBREW_PREFIX}/bin/python3.9

      # Additional search paths for python modules. PYTHONPATH will be set to this
      # value if esoreflex.inherit-environment=FALSE. However, the contents of
      # esoreflex.python-path will be appended to any existing PYTHONPATH from the
      # user's environment if esoreflex.inherit-environment=TRUE. Note that removing
      # any paths that were added during the installation may break esoreflex.
      esoreflex.python-path=#{HOMEBREW_PREFIX}/share/esoreflex/esoreflex/python

      # Additional search paths for binaries. This will be prepended to the default
      # system PATH as returned by getconf if esoreflex.inherit-environment=FALSE.
      # Otherwise the contents is appended to the user's PATH environment variable if
      # esoreflex.inherit-environment=TRUE. Note that removing any paths that were
      # added during the installation may break esoreflex.
      esoreflex.path=#{HOMEBREW_PREFIX}/bin

      # Additional search paths for shared libraries. DYLD_LIBRARY_PATH will be set
      # to this if esoreflex.inherit-environment=FALSE. However, the contents of
      # esoreflex.library-path will be appended to any existing DYLD_LIBRARY_PATH
      # variables from the user's environment if esoreflex.inherit-environment=TRUE.
      # Note that removing any paths that were added during the installation may break
      # esoreflex.
      esoreflex.library-path=
    EOS

    inreplace pkgshare/"esoreflex/bin/esoreflex" do |s|
      s.gsub! "$(dirname $0)/../..", HOMEBREW_PREFIX/"share/esoreflex"
      s.gsub! kepler_workflows, HOMEBREW_PREFIX/"share/reflex/workflows:#{kepler_workflows}"
      s.gsub! "/etc/esoreflex.rc", HOMEBREW_PREFIX/"etc/esoreflex.rc"
      s.gsub! 'LOAD_ESOREX_CONFIG=""', "LOAD_ESOREX_CONFIG=#{HOMEBREW_PREFIX}/etc/esorex.rc"
      s.gsub! 'LOAD_ESOREX_RECIPE_CONFIG=""', "LOAD_ESOREX_CONFIG=#{esoreflex_default_recipe_config}"
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
