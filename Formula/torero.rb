class Torero < Formula
  desc "torero is a simple to use, single binary tool to create, manage, deploy, maintain, and serve automations as services."
  homepage "https://torero.dev"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "MIT"

  resource "mac_amd" do
    url "https://download.torero.dev/torero-v1.3.0-darwin-amd64.tar.gz"
    sha256 "654758e5dc1b799feaee6229d3378abfa8ff7ff7df72e9c12215776c9633816a"
  end

  resource "mac_arm" do
    url "https://download.torero.dev/torero-v1.3.0-darwin-arm64.tar.gz"
    sha256 "20c312ef4016d37f701c3ce2a5b0b37ebb6304f7020dd567f25c368beac0e25f"
  end

  resource "linux_amd" do
    url "https://download.torero.dev/torero-v1.3.0-linux-amd64.tar.gz"
    sha256 "ef99444ea08455b2eb7e16bc32f7d8193b9d1247f8fb08dec7ac22d63c6286d7"
  end

  resource "linux_arm" do
    url "https://download.torero.dev/torero-v1.3.0-linux-arm64.tar.gz"
    sha256 "de9b3f239d9f1adee2711906e18cd0fdec2f69f5da3513f443a71a956d1cb4a8"
  end

  def install
    on_macos do
      on_amd do
        resource("mac_amd").stage { bin.install "./torero" => "torero" }
      end

      on_arm do
        resource("mac_arm").stage { bin.install "./torero" => "torero" }
      end
    end

    on_linux do
      on_amd do
        resource("linux_amd").stage { bin.install "./torero" => "torero" }
      end

      on_arm do
        resource("linux_arm").stage { bin.install "./torero" => "torero" }
      end
    end
  end

  def post_install
    system bin/"torero", "--version"
  end

  test do
    assert_predicate bin/"torero", :exist?

    system bin/"torero", "--version"
  end
end
