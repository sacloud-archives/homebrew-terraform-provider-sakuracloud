class TerraformProviderSakuracloud < Formula

  _version = "0.14.0"
  sha256_src_darwin = "14be766032b3a12e50d32ce3d91ab49eeb1c1f60e2200d5a52f5e3ce9bf1d376"
  sha256_src_linux = "ff891be1b86e8753e9a6a4cf4aee1de29ca53feb024b6bdb5e8c8befd4891cc1"

  desc "Terraform provider plugin for SakuraCloud"
  homepage "https://github.com/sacloud/terraform-provider-sakuracloud"
  head "https://github.com/sacloud/terraform-provider-sakuracloud.git"
  version _version

  if OS.mac?
    url "https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v#{_version}/terraform-provider-sakuracloud_darwin-amd64.zip"
    sha256 sha256_src_darwin
  else
    url "https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v#{_version}/terraform-provider-sakuracloud_linux-amd64.zip"
    sha256 sha256_src_linux
  end

  depends_on "terraform" => :run

  def install
    bin.install "terraform-provider-sakuracloud"
  end

  def caveats; <<-EOS.undent

    This plugin requires "~/.terraformrc" file.
    To enable, put following text in "~/.terraformrc":

        providers {
            sakuracloud = "#{bin}/terraform-provider-sakuracloud"
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
