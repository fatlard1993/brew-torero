# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class ToreroV130DarwinAmd < Formula
  desc ""
  homepage ""
  url "https://download.torero.dev/torero-v1.3.0-darwin-amd64.tar.gz"
  sha256 "654758e5dc1b799feaee6229d3378abfa8ff7ff7df72e9c12215776c9633816a"
  license ""

  # depends_on "cmake" => :build

  # Additional dependency
  # resource "" do
  #   url ""
  #   sha256 ""
  # end

  def install
    # Remove unrecognized options if they cause configure to fail
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    system "tar", "-xzvf", "torero-v1.3.0-darwin-amd64.tar.gz"
    system "mv", "./torero", "/usr/local/bin/torero"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
  end

  def post_install
    system "torero", "get", "services" 
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test torero-v1.3.0-darwin-amd`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    echo "Success"? echo "Failure" if File.exist?("/usr/local/bin/torero")
  end
end
