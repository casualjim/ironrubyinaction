=begin
= $RCSfile$ -- SSL/TLS enhancement for Net::HTTP.

= Info
  'OpenSSL for Ruby 2' project
  Copyright (C) 2003 Blaz Grilc <farmer@gmx.co.uk>
  All rights reserved.

= Licence
  This program is licenced under the same licence as Ruby.
  (See the file 'LICENCE'.)

= Requirements

= Version
  $Id: ftptls.rb 11708 2007-02-12 23:01:19Z shyouhei $
  
= Notes
  Tested on FreeBSD 5-CURRENT and 4-STABLE
  - ruby 1.6.8 (2003-01-17) [i386-freebsd5]
  - OpenSSL 0.9.7a Feb 19 2003
  - ruby-openssl-0.2.0.p0
  tested on ftp server: glftpd 1.30
=end

require 'socket'
require 'openssl'
require 'net/ftp'

module Net
  class FTPTLS < FTP
    def login(user = "anonymous", passwd = nil, acct = nil)
       ctx = OpenSSL::SSL::SSLContext.new('SSLv23')
       ctx.key = nil
       ctx.cert = nil
       voidcmd("AUTH TLS")
       @sock = OpenSSL::SSL::SSLSocket.new(@sock, ctx)
       @sock.connect
       super(user, passwd, acct)
       voidcmd("PBSZ 0")
    end
  end
end
