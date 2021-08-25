class Tfbackend < Formula
  desc "Simple cli tool to create terraform backend at a blistering speed🚀🚀"
  homepage "https://github.com/Jimon-s/tfbackend"
  url "https://github.com/Jimon-s/tfbackend/archive/v1.0.1.tar.gz"
  sha256 "011acabc60a9a55c3737d41a500cc2f7e5efdfa1fcdbd258b006aad8a7844585"
  license "MIT"

  depends_on "go" => :build

  def install
    # Install tfbackend command
    system "go", "build"
    bin.install "tfbackend"

    # Install bash completion
    output = Utils.safe_popen_read("#{bin}/tfbackend", "completion", "bash")
    (bash_completion/"tfbackend").write output

    # Install zsh completion
    output = Utils.safe_popen_read("#{bin}/tfbackend", "completion", "zsh")
    (zsh_completion/"_tfbackend").write output
  end

  test do
    run_output = shell_output("#{bin}/tfbackend completion")
    want = "Usage:\n\
  tfbackend completion\n\
\n\
Flags:\n\
  -h, --help   help for completion\n\
\n\
[ERROR]: accepts 1 arg(s), received 0"
    assert_match want, run_output
  end
end
