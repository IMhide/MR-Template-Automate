module Steps
  class GetToSignin
    def initialize(prompt, agent, url)
      @prompt = prompt
      @agent = agent
      @url = url
    end

    def call
      puts 'Connecting to your Gitlab'
      page = @agent.get(@url + '/users/sign_in')
      form = page.forms.first
      email = @prompt.ask("What is your Gitlab email or Username")
      password = @prompt.mask("What is your Gitlab password")
      form.field_with(name: 'user[login]').value = email
      form.field_with(name: 'user[password]').value = password
      page = @agent.submit(form)
      puts page.inspect
    end
  end
end
