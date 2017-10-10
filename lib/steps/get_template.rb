module Steps
  class GetTemplate
    def initialize(prompt)
      @prompt = prompt
    end

    def call
      markdowns = Dir['*.md']
      case markdowns.size
      when 0
        puts "No Markdown file founded in the current directory"
        exit(1)
      when 1
        puts 'You chose : ' + markdowns.first 
        markdowns.first
      else
        choice = @prompt.enum_select("Choose your Markdown template", markdowns)
        puts 'You chose : ' + choice
        choice
      end
    end
  end
end
