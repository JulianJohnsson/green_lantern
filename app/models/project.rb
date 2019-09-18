class Project < ApplicationRecord
  enum kind: ["Secret", "🌳 Protection", "🌳 Reforestation"]
end
