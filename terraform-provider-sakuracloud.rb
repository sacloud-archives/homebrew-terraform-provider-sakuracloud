class TerraformProviderSakuracloud < Formula

  _version = "1.3.1"
  sha256_src_darwin = "94bd77b086eddd40a57900a1277debe05b4a3784713e3aa7dea8cfd43b07b443"
  sha256_src_linux = "561eb63e8a8df5ba690fdcb5f921da9a368e5e1d714d0f9cfb1bac6533690066"

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

  depends_on "terraform"

  def install
    bin.install "terraform-provider-sakuracloud_v1.3.1_x4"
  end

  def caveats; <<~EOS

    This plugin needs to be placed in "~/.terraform.d/plugins" directory.
    To enable, run following command to make symbolic link:

         ln -s #{bin}/terraform-provider-sakuracloud_v1.3.1_x4 ~/.terraform.d/plugins/terraform-provider-sakuracloud_v1.3.1_x4

  EOS
  end

  test do
    minimal = testpath/"minimal.tf"
    minimal.write <<~EOS
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
