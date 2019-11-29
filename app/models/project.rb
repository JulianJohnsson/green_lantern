class Project < ApplicationRecord
  enum kind: ["❔ Secret", "🌳 Protection", "🌳 Reforestation", "🌬 Parc éolien", "🔥 Alimentation saine"]
end
