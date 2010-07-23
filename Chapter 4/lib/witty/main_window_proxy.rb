module Witty

  class MainWindowViewModel
    include WpfBehavior::Databinding
    attr_accessor :status_bar_message, :tweets, :update_text

    def initialize(params={})
      params.each { |k,v| instance_variable_set :"@#{k}", v }
    end
  end

  class MainWindowProxy

    include Witty::XamlProxy

    attr_reader :current_user, :credentials, :view_model

    def initialize
      load_view
      @view_model = MainWindowViewModel.new
      @view_model.tweets = TweetCollection.new []
      @view_model.status_bar_message = "Please login"

      add_login_view

      refresh_button.click do |s,e|
        refresh_tweets
      end
      upd_act = lambda { |s,e| toggle_update }
      update.mouse_left_button_up &upd_act
      update_button.click &method(:update_status)

      add_refresh_timer

      view.data_context = @view_model
    end

    def update_status(s, e)
      tweet = Status.update_status @update_text.to_s.with_shortened_urls, credentials
      view_model.status_bar_message = "Tweet sent"
      play_storyboard 'CollapseUpdate'
      @expanded = false
      view_model.update_text = ''
      view_model.tweets.insert 0, tweet if tweet
    end

    def refresh_tweets
      view_model.tweets.merge! Status.timeline_with_friends(credentials)
      view_model.status_bar_message = "Refreshed tweets"
      refresh
    end

    def logged_in(s, e)
      unless @current_user.nil?
        view_model.tweets = Status.timeline_with_friends credentials
        view_model.status_bar_message = "Received tweets"
      end
    end

    def toggle_update
      if logged_in?
        if @expanded
          play_storyboard "CollapseUpdate"
        else
          play_storyboard "ExpandUpdate"
          tweet_text_box.focus
        end
        @expanded = !@expanded
      end
    end

    private
    def add_login_view
      login_view = LoginControlProxy.new
      add_control :content, login_view.view
      login_view.on_status_change do |msg|
        view_model.status_bar_message = msg
        refresh
      end
      login_view.on_logged_in do |credentials, user|
        @current_user = user
        @credentials = credentials
        login_view.visibility = :hidden
        logged_in(nil, nil)
      end
    end

    def add_refresh_timer
      ti = @refresh_tweets_timer = DispatcherTimer.new
      ti.interval = 2.minutes.to_timespan
      ti.tick &method(:refresh_tweets)
      start_timer
    end

    def start_timer
      @refresh_tweets_timer.start
    end

    def stop_timer
      @refresh_tweets_timer.stop
    end

    def logged_in?
      !!@current_user
    end
  end

end
