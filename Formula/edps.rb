class Edps < Formula
  include Language::Python::Virtualenv

  desc "ESO Data Processing System"
  homepage "https://www.eso.org/sci/software/pipelines/"
  url "https://ftp.eso.org/pub/dfs/pipelines/libraries/edps/edps-1.1.1.tar.gz"
  sha256 "65aaf200f470c58337cf5bdfcdd53165cdd202ec38f3b8d902f552b2293306d2"
  license "MIT"

  depends_on "python@3.9"
  depends_on "pyyaml"
  depends_on "numpy"

  resource "astropy" do
    url "https://files.pythonhosted.org/packages/8d/52/376379d9a1929f788fc8113e1bfc010c2cb7c7efa67e6f3585321d60bba9/astropy-5.3.tar.gz"
    sha256 "1f694be1c2b32309aca15cf7b54aa17546e944135209394cdceebd7a7889e4e5"
  end

  resource "fastapi" do
    url "https://files.pythonhosted.org/packages/b9/ed/3f155c5f0f3a2d1bac596800be1cdd2bda38cee84b7cee7c35eecd0ddd09/fastapi-0.99.0.tar.gz"
    sha256 "eab70f072d6c424d16f02ba635dc0945fecab549210e7961c838f4b467f0b4a7"
  end

  resource "networkx" do
    url "https://files.pythonhosted.org/packages/fd/a1/47b974da1a73f063c158a1f4cc33ed0abf7c04f98a19050e80c533c31f0c/networkx-3.1.tar.gz"
    sha256 "de346335408f84de0eada6ff9fafafff9bcda11f0a0dfaa931133debb146ab61"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/be/10918a2eac4ae9f02f6cfe6414b7a155ccd8f7f9d4380d62fd5b955065c3/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "uvicorn" do
    url "https://files.pythonhosted.org/packages/c6/dd/0d3bab50ab4ef8bec849f89fec2adc2fabcc397018c30e57d9f0d4009c5e/uvicorn-0.22.0.tar.gz"
    sha256 "79277ae03db57ce7d9aa0567830bbb51d7a612f54d6e1e3e92da3ef24c2c8ed8"
  end

  resource "tinydb" do
    url "https://files.pythonhosted.org/packages/30/0b/9e75a8d3333a6a3d9b36de04bf87a37a8d7f100035ea23c9c37bf0a112ab/tinydb-4.8.0.tar.gz"
    sha256 "6dd686a9c5a75dfa9280088fd79a419aefe19cd7f4bd85eba203540ef856d564"
  end

  resource "frozendict" do
    url "https://files.pythonhosted.org/packages/09/73/e3a2f0181a25b189429796f1d33d35658b68c22ec4792fa22d3caebcfc45/frozendict-2.3.8.tar.gz"
    sha256 "5526559eca8f1780a4ee5146896f59afc31435313560208dd394a3a5e537d3ff"
  end

  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/7a/ff/75c28576a1d900e87eb6335b063fab47a8ef3c8b4d88524c4bf78f670cce/Jinja2-3.1.2.tar.gz"
    sha256 "31351a702a408a9e7595a8fc6150fc3f43bb6bf7e319770cbc0db9df9437e852"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system "true"
  end
end
