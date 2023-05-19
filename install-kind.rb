require "formula"
class InstallKind < Formula
  desc "Description of myscript"
  homepage "https://github.com/Abhimanyu9988?tab=repositories"
  url "https://github.com/appdynamics-support/kind-kubernetes/raw/main/install-kind.tgz"
  sha256 "1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef"
  version "1.0.0"
  def install
    bin.install "install-kind.sh"
  end
end
