require 'formula'

class Sshpass < Formula
  desc "Non-interactive ssh password authentication"
  url 'http://sourceforge.net/projects/sshpass/files/sshpass/1.10/sshpass-1.10.tar.gz'
  homepage 'http://sourceforge.net/projects/sshpass'
  sha256 'ad1106c203cbb56185ca3bad8c6ccafca3b4064696194da879f81c8d7bdfeeda'
  license "GPL-2.0-or-later"
  version "1.10"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make","install"
  end

  test do
    assert_match "ssh: Could not resolve hostname host: nodename nor servname provided, or not known",
      shell_output("#{bin}/sshpass -p mypassword ssh username@host touch foo 2>&1", 255)

    assert_match "sshpass #{version}", shell_output("#{bin}/sshpass -V")
  end
end
