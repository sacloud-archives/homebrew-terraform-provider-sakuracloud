class TerraformProviderSakuracloud < Formula

  _version = "1.9.1"
  sha256_src_darwin = "c0101180ee129a48d5146846c6c3b62206f490317d7643c5630c6c3cf454159f"
  sha256_src_linux = "045495df90076e6af5e9172f44bbc5228c1520775b6e1cf6dfe5d17deb4fd82f"

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
    bin.install "terraform-provider-sakuracloud_v1.9.1_x4"
  end

  def caveats; <<~EOS

    This plugin needs to be placed in "~/.terraform.d/plugins" directory.
    To enable, run following command to make symbolic link:

         ln -s #{bin}/terraform-provider-sakuracloud_v1.9.1_x4 ~/.terraform.d/plugins/terraform-provider-sakuracloud_v1.9.1_x4

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
