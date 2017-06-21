class TerraformProviderSakuracloud < Formula

  _version = "0.10.2"
  sha256_src = "91ea9cf8fa6abe555b879dc3571508ace7445c28d041e78c3ec49aa09afa3ef1"

  desc "Terraform provider plugin for SakuraCloud"
  homepage "https://github.com/sacloud/terraform-provider-sakuracloud"
  url "https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v#{_version}/terraform-provider-sakuracloud_darwin-amd64.zip"
  sha256 sha256_src
  head "https://github.com/sacloud/terraform-provider-sakuracloud.git"
  version _version

  depends_on "terraform" => :run

  def install
    bin.install "terraform-provider-sakuracloud"
  end

  def caveats; <<-EOS.undent

    This plugin requires "~/.terraformrc" file.
    To enable, put following text in "~/.terraformrc":

        providers {
            sakuracloud = "terraform-provider-sakuracloud"
        }

  EOS
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
