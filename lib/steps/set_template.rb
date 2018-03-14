module Steps
  class SetTemplate
    def initialize(agent, url, path, file)
      @agent = agent
      @url = url
      @path = path
      @file = file
    end

    def call
      links = get_projects_path
      set_template(links)
    end

    def get_projects_path
      page = @agent.get(@url + '/' +@path)
      links = []
      while true do
        links.push(page.css('a.project').map{|l| l.attribute('href').value})
         break if @agent.page.links_with(text: 'Last »').empty?
         page = @agent.page.links_with(text: 'Next').first.click
      end
      links.flatten.uniq
    end
    
    def set_template(links)
      links.each do |link|
        page = @agent.get(@url + link + '/edit')
        form = page.form_with(class: 'merge-request-settings-form')
        form.field_with(name: 'project[merge_requests_template]').value = @file
        @agent.submit(form)
      end
    end
  end
end
