module AresMUSH
    module Tor
        
        
        
        def culture_skills(char, culture_name)
            culture_name = Tor.find_culture(char, culture_name)
            skills = Global.read_config('tor', 'cultures', 'starting_skills')
            return if !skills
            skills.each do |k, v|
                skill = Tor.find_skill(char, k)
                rating = Tor.skill_rating(char, v)
                if (skill)
                    skill.update(rating)
                  else
                    TorSkills.create(name: self.skill, rating: self.rating, character: char)
                  end
            end
        end