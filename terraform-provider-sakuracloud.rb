class TerraformProviderSakuracloud < Formula

  _version = "1.0.4"
  sha256_src_darwin = "53634431299568423aadb17be8246ece4b2b6765141c01e2cac6b7e454d26c70"
  sha256_src_linux = "7f6bdbe5c73e8252611b9a97e6121ce9aac8231ef50f1d644dab2814d2ad0106"

  desc "Terraform provider plugin for SakuraCloud"
  homepage "https://github.com/sacloud/terraform-provider-sakuracloud"
  head "https://github.com/sacloud/terraform-provider-sakuracloud.git"
  version _version

  if OS.mac?
    url "https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v#{_version}/terraform-provider-sakuracloud_#{_version}_darwin-amd64.zip"
    sha256 sha256_src_darwin
  else
    url "https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v#{_version}/terraform-provider-sakuracloud_#{_version}_linux-amd64.zip"
    sha256 sha256_src_linux
  end

  depends_on "terraform" => :run

  def install
    bin.install "terraform-provider-sakuracloud_v1.0.4_x4"
  end

  def caveats; <<-EOS.undent

    This plugin requires "~/.terraformrc" file.
    To enable, put following text in "~/.terraformrc":

        providers {
            sakuracloud = "#{bin}/terraform-provider-sakuracloud_v1.0.4_x4"
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
