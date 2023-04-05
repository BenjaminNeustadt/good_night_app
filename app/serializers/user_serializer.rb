class UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :sleeps, :followers

    def sleeps
        self.object.sleeps.map do |sleep| 
                
            { created_at: sleep.created_at,
              updated_at: sleep.updated_at == sleep.created_at ? "Still sleeping..." : sleep.updated_at
            }
        end
    end


end