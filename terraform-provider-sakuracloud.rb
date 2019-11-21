class TerraformProviderSakuracloud < Formula

  _version = "1.20.0"
  sha256_src_darwin = "d18d776ef70bce8407d46f0e197cae9e01a179edc8c98c52152c3b8c44b7d05c"
  sha256_src_linux = "cbc228f0adcf8c0ecfe06c223af7e024cd10a2e40926197905475f84241be376"

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
    bin.install "terraform-provider-sakuracloud_v1.20.0"
  end

  def caveats; <<~EOS

    This plugin needs to be placed in "~/.terraform.d/plugins" directory.
    To enable, run following command to make symbolic link:

         ln -s #{bin}/terraform-provider-sakuracloud_v1.20.0 ~/.terraform.d/plugins/terraform-provider-sakuracloud_v1.20.0

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
