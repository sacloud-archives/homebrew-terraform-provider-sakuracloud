class TerraformProviderSakuracloud < Formula

  _version = "1.7.1"
  sha256_src_darwin = "93f181699a1f56576320e7778e5a8dcc460e1bfdd84d9fa4fa583623b3a3d3bc"
  sha256_src_linux = "61911c75419db491bec18cbb6c8596346ce773ec8087f33b9a789ef829611703"

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
    bin.install "terraform-provider-sakuracloud_v1.7.1_x4"
  end

  def caveats; <<~EOS

    This plugin needs to be placed in "~/.terraform.d/plugins" directory.
    To enable, run following command to make symbolic link:

         ln -s #{bin}/terraform-provider-sakuracloud_v1.7.1_x4 ~/.terraform.d/plugins/terraform-provider-sakuracloud_v1.7.1_x4

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
