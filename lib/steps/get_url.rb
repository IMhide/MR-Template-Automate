module Steps
  class GetUrl
    def initialize(prompt)
      @prompt = prompt
    end

    def call
      url = @prompt.ask('What is your GitLab URL ? (with the http(s)://)')
      if !!(url =~ URI.regexp)
        puts 'Gitlab Url set to :' + url 
      else
        puts url + ' is not an url'
        exit(1)
      end
      url
    end
  end
end
