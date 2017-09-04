class TerraformProviderSakuracloud < Formula

  _version = "0.12.0"
  sha256_src_darwin = "5f4c8da7d54855d98826472c6ad4c8219ea8f370d2a1bcb318b8ca4e294618bd"
  sha256_src_linux = "ecb325c475b04ca7d7ce5ab3068028172dd77de9ea7d4788f2488ebe723c0e84"

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
