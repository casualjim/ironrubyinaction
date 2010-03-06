module Witty
  class LoginControlProxy
    include Witty::XamlProxy
    include WpfBehavior::Databinding

    def initialize
      load_view
      view.loaded { |_, _| self.username.focus }
      login_button.click &method(:authenticate)
    end

    def on_logged_in(&b)
      @login_handlers ||= []
      @login_handlers << b if b
    end

    def logged_in(credentials, user)
      @login_handlers.each { |h| h.call credentials, user }
    end

    def on_status_change(&b)
      @status_change_handlers ||= []
      @status_change_handlers << b if b
    end

    def update_status_message(message)
      @status_change_handlers.each { |h| h.call message }
    end

    def authenticate(s, e)
      update_status_message "Logging in"
      credentials = Credentials.new username.text, password.password.to_s.to_secure_string
      current_user = User.login(credentials)
      logged_in credentials, current_user #unless current_user.nil?
      if current_user
        username.text = ""
        password.password = ""
      end
    end
  end
end