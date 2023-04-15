require 'formula'

class Sshpass < Formula
  version "1.10"
  sha256 "ad1106c203cbb56185ca3bad8c6ccafca3b4064696194da879f81c8d7bdfeeda"

  url "https://downloads.sourceforge.net/project/sshpass/sshpass/#{version}/sshpass-#{version}.tar.gz"
  desc "Non-interactive ssh password authentication"
  homepage "http://sourceforge.net/projects/sshpass"
  license "GPL-2.0-or-later"

  def install
    system "./configure", 
                "--disable-debug", 
                "--disable-dependency-tracking",
                "--prefix=#{prefix}"
    system "make install"
  end

  test do
    assert_match "ssh: Could not resolve hostname host: nodename nor servname provided, or not known",
      shell_output("#{bin}/sshpass -p mypassword ssh username@host touch foo 2>&1", 255)
    assert_match "sshpass #{version}", shell_output("#{bin}/sshpass -V")
  end
end
