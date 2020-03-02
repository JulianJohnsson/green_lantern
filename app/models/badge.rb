class Badge < ApplicationRecord
  has_and_belongs_to_many :users

  enum family: ["Comprendre les bases", "Améliorer mon estimation", "Passer à l'action", "Sensibiliser mon entourage", "M'engager à long terme", "Devenir un ambassadeur"]

end
