class Torero < Formula
  desc "Create, manage, deploy, maintain, and serve automations as services"
  homepage "https://torero.dev"
  url "file:///dev/null"
  version "1.3.1"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.intel?
        url "https://download.torero.dev/torero-v1.3.1-darwin-amd64.tar.gz"
        sha256 "8e756199350d6d6d2fd19f7e9633ae513cf7875edce9c9d2ba40757dc046a2b3" # darwin-amd64
    elsif Hardware::CPU.arm?
        url "https://download.torero.dev/torero-v1.3.1-darwin-arm64.tar.gz"
        sha256 "a83bad0f2cec3cb93363f8df70624a4e3f547da6180946091a97fe332f21e50f" # darwin-arm64
    else
      odie "Unsupported architecture"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
        url "https://download.torero.dev/torero-v1.3.1-linux-amd64.tar.gz"
        sha256 "c15e4c0878035d1587057434bdbd8b324aa669bb5fbcc9b4ac1e21c4f685a717" # linux-amd64
    elsif Hardware::CPU.arm?
        url "https://download.torero.dev/torero-v1.3.1-linux-arm64.tar.gz"
        sha256 "ac61264702e50040e0d8c0acdd9c6aff822a5abb92142108f69cbfe96f25ee84" # linux-arm64
    else
      odie "Unsupported architecture"
    end
  else
    odie "Unsupported architecture"
  end

  resource "setupScript" do
    url "https://github.com/fatlard1993/homebrew-torero/archive/refs/tags/setupScript.tar.gz"
    sha256 "c4aa55b11bd35ab8910c732229c2058635fc188ef8c378e05360520dbdda76ce"
  end

  def install
    ohai "------- Installing Torero -------"

    bin.install "./torero" => "torero"

    resource("setupScript").stage { bin.install "./setup.sh" => "torero-setup" }
  end

  def post_install
    ohai "Successfully installed! :: For a guided configuration, run: torero-setup"
  end

  test do
    ohai "------- Testing Torero Install -------"

    assert_path_exists bin/"torero"
  end
end
