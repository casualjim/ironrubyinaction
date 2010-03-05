module System

  module Security

    class SecureString

      def to_insecure_string
        Witty::SecureString.unsecure_string self
      end

      def encrypt
        Witty::SecureString.encrypt_string self
      end
    end

  end

end