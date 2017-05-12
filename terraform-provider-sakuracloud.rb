class TerraformProviderSakuracloud < Formula

  _version = "0.9.1"
  sha256_src = "b82c22063b431023b36692bff53e13a222fda5fd7d8eed971efce452d42cd47a"

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

  def caveats; <<-EOS.undent

    This plugin requires "~/.terraformrc" file.
    To enable, put following text in "~/.terraformrc":

        providers = {
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
