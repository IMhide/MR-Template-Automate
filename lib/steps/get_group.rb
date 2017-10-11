module Steps
  class GetGroup
    def initialize(prompt, agent, url)
      @prompt = prompt
      @agent = agent
      @url = url
    end

    def call
      raw = @agent.get(@url + '/dashboard/groups.json')
      json = JSON.parse(raw.body)    
      choice = @prompt.enum_select("Choose a group", json.map{|h| h['name']})
      json.find{ |a| a['name'] == choice }['path']
    end

  end
end

