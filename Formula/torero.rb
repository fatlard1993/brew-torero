class Torero < Formula
  desc "torero is a simple to use, single binary tool to create, manage, deploy, maintain, and serve automations as services."
  homepage "https://torero.dev"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "MIT"

  resource "mac_amd" do
    url "https://download.torero.dev/torero-v1.3.0-darwin-amd64.tar.gz"
    sha2 "d6001379610b0c5febbe86cc6bf17ecca13b98be7d4e08d684eea0e3aaea44d118d11caec652aa23fa8790a1018f522d91b9295af855a686f289e9b2fc684581"
  end

  resource "mac_arm" do
    url "https://download.torero.dev/torero-v1.3.0-darwin-arm64.tar.gz"
    sha2 "99c976657c7f176273b4732922836a2f3cc36bdf96e5eab01162c8e9cdd0c74bb5188b0f5b99efd467e2db525d32d61d1beed5ca488c06105f97e9947603a9fb"
  end

  resource "linux_amd" do
    url "https://download.torero.dev/torero-v1.3.0-linux-amd64.tar.gz"
    sha2 "2e91bfd06e232d80493717896d22b8094a136be7dbabdcc4c6ccd489e187a08eae6415d9d40baa199943c9f81a2515e40e8928515e8f10c58995e004c12706c6"
  end

  resource "linux_arm" do
    url "https://download.torero.dev/torero-v1.3.0-linux-arm64.tar.gz"
    sha2 "5cde3613aff02df6854e1b48ef614000111f11d082b2d779bc7d2b532ca288cfba759ae01e8436e8ae1bf7b8afa1c5d805eebacd221eac51ef314d3eddb9d2ca"
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
