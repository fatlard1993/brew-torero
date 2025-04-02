class Torero < Formula
  desc "Create, manage, deploy, maintain, and serve automations as services"
  homepage "https://torero.dev"
  url "file:///dev/null"
  version "1.3.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.intel?
      resource "torero_resource" do
        url "https://download.torero.dev/torero-v1.2.0-darwin-amd64.tar.gz"
        sha256 "db868e450c54a492938074d1d20e07401123429bea58448a6cb69ba591dcbb4a" # darwin-amd64
      end
    end

    if Hardware::CPU.arm?
      resource "torero_resource" do
      url "https://download.torero.dev/torero-v1.2.0-darwin-arm64.tar.gz"
      sha256 "c592d592d6ec02f045cabb43a87d7b649038a4114a2ca8f54aefff7150ad37ae" # darwin-arm64
      end
    end
  end

  if OS.linux?
    if Hardware::CPU.intel?
      resource "torero_resource" do
      url "https://download.torero.dev/torero-v1.2.0-linux-amd64.tar.gz"
      sha256 "bb20c1834515825c2b384a09bb8b06beb0e37ba841a3c1f6af536390601b83ca" # linux-amd64
      end
    end

    if Hardware::CPU.arm?
      resource "torero_resource" do
      url "https://download.torero.dev/torero-v1.2.0-linux-arm64.tar.gz"
      sha256 "53847d268f7197f321ce6e5af672452c595eccd6e9803dba3809a76c7f4fa221" # linux-arm64
      end
    end
  end

  def install
    resource("torero_resource").stage { bin.install "./torero" => "torero" }
  end

  def post_install
    puts "------ RUNNING POST INSTALL ------"
    system bin/"torero"
  end

  test do
    puts "------ RUNNING TESTS ------"
    assert_path_exists bin/"torero"
  end
end