module TweetsHelper
    
    def render_with_hashtags(text)
        text.gsub(/(?:#(\w+))/) {hashtag_link($1)}
    end
    def hashtag_link(hash)
        link_to "##{hash}", hashtags_path(hashtag: "##{hash}"), :class => "rst"
    end


    # def render_with_hashtags(content)
    #     content_words = content.split(" ")
    #     content_with_links = content_words.map do |word| 
    #       if word.include?("#")
    #         link_to word, hashtags_path(hashtag: word)
    #       else
    #         word
    #       end
    #     end
    
    #     content_with_links.join(" ")
    #   end
    

end
