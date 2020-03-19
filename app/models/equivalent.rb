class Equivalent < ApplicationRecord
  enum kind: [:weight, :production, :distance, :treat]
  def self.random(subject, carbone_amount)
    equivalent = Equivalent.all.where("carbone_min*2 <= ?", carbone_amount).sample || Equivalent.all.where("carbone_min*2 <= 1").sample
    sentence = equivalent.build_sentence(subject, carbone_amount)
    return equivalent.id, sentence
  end

  def build_sentence(subject, carbone_amount)
    sentence = ""
    case self.kind.to_sym when :weight
      sentence = subject + ", c'est l'équivalent du poids de " + (carbone_amount.to_f / self.carbone_min.to_f).to_i.to_s + " " + self.name
    when :production
      sentence = subject + ", c'est autant de CO2 que pour la fabrication de " + (carbone_amount.to_f / self.carbone_min.to_f).to_i.to_s + " " + self.name
    when :distance
      sentence = subject + ", c'est autant de CO2 généré par une balade de " + (carbone_amount.to_f / self.carbone_min.to_f).to_i.to_s + "km en " + self.name
    when :treat
      sentence = "Si tu prenais " + (carbone_amount.to_f / self.carbone_min.to_f).to_i.to_s + " " + self.name + ", ça générerait autant de C02 que " + subject.downcase
    end
  end
end
