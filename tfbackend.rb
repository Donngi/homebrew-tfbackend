class Tfbackend < Formula
  desc "Simple cli tool to create terraform backend at a blistering speed🚀🚀"
  homepage "https://github.com/Jimon-s/tfbackend"
  url "https://github.com/Jimon-s/tfbackend/archive/v1.0.0.tar.gz"
  sha256 "e68199c7e876e488575222f5fdfc612671b88e83531e2869189ca61dfe515ca0"
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
