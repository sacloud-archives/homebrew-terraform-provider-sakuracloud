class TerraformProviderSakuracloud < Formula

  _version = "0.7.2"
  sha256_src = "a7655a30655f4f06aaf33f12a660fb683e288ed0954d551f6ad54c9f94c32cdf"

  desc "Terraform provider plugin for SakuraCloud"
  homepage "https://github.com/yamamoto-febc/terraform-provider-sakuracloud"
  url "https://github.com/yamamoto-febc/terraform-provider-sakuracloud/releases/download/v#{_version}/terraform-provider-sakuracloud_darwin-amd64.zip"
  sha256 sha256_src
  head "https://github.com/yamamoto-febc/terraform-provider-sakuracloud.git"
  version _version

  depends_on "terraform" => :run

  def install
    bin.install "terraform-provider-sakuracloud"
  end

  test do
    minimal = testpath/"minimal.tf"
    minimal.write <<-EOS.undent
      # Specify the provider and access details
      provider "sakuracloud" {
        token = "this_is_a_fake_token"
        secret = "this_is_a_fake_secret"
        zone = "tk1v"
      }
      resource "sakuracloud_server" "server" {
        name = "server"
      }
    EOS
    system "#{bin}/terraform", "graph", testpath
  end
end
