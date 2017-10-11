module Steps
  class Signin
    def initialize(prompt, agent, url)
      @prompt = prompt
      @agent = agent
      @url = url
    end

    def call
      page = basic_sign_in
      form = page.forms.first
      page = two_factor(form) unless form.field_with(name: 'user[otp_attempt]').nil?
      page
    end

    def basic_sign_in
      puts 'Connecting to your Gitlab'
      page = @agent.get(@url + '/users/sign_in')
      form = page.forms.first
      email = @prompt.ask("What is your Gitlab email or Username")
      password = @prompt.mask("What is your Gitlab password")
      form.field_with(name: 'user[login]').value = email
      form.field_with(name: 'user[password]').value = password
      @agent.submit(form)
    end

    def two_factor(form)
      tfa = @prompt.ask("Enter your Two Factor token")
      form.field_with(name: 'user[otp_attempt]').value = tfa
      @agent.submit(form)
    end

  end
end
