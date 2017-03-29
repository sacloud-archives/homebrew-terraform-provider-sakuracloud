class TerraformProviderSakuracloud < Formula

  _version = "0.7.3"
  sha256_src = "eda4da3ecc57ffdc0112fd59cbabf1a37c3e1da88ab09f6762972134d940f3c8"

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
