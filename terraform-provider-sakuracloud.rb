class TerraformProviderSakuracloud < Formula

  _version = "1.0.0"
  sha256_src_darwin = "31476924fef482e8961a9d9800d4ea3109a3d1f58b23808300730d65c83f92e7"
  sha256_src_linux = "ad1ec61e49e942ce12168085587bc5485b5cb90fb2a1f521b7ae30a52c086b6d"
  bin_name = "terraform-provider-sakuracloud_#{_version}_x4"

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
    bin.install "terraform-provider-sakuracloud_v1.0.0_x4"
  end

  def caveats; <<-EOS.undent

    This plugin requires "~/.terraformrc" file.
    To enable, put following text in "~/.terraformrc":

        providers {
            sakuracloud = "#{bin}/terraform-provider-sakuracloud_v1.0.0_x4"
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
