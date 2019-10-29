class Match < ApplicationRecord

  scope :user_matches, -> (int) {where("user_id IS NULL OR user_id = ?", int)}

  def get_match_data(user)
    raw_user_data = self.get_user_data(user)
    opponent_data = self.get_opponent_data
    user_total = raw_user_data.map { |c,v| v }.inject(0){|sum,x| sum.to_i + x.to_i }
    opponent_total = opponent_data.inject(0){|sum,x| sum.to_i + x.to_i }
    chart_data = {
      labels: raw_user_data.map { |c,v| c.emoji },
      datasets: [
        { label: 'Toi', data: raw_user_data.map { |c,v| v }, borderColor: "#6C63FF" },
        { label: self.name, data: opponent_data, borderColor: "#FF8550" }
      ]
    }
    return chart_data, raw_user_data, opponent_data, user_total, opponent_total
  end

  def get_user_data(user)
    categories = Category.all.parent_categories
    transactions = user.transactions.recent.carbone_contribution
    raw_user_data = categories.sort_by {|c| c.id}.map {|c| [c, transactions.parent_category_id(c.id).sum(:carbone)]}
    raw_user_data
  end

  def get_opponent_data
    if self.data != []
      opponent_data = self.data
    else
      opponent = User.find(self.opponent_id)
      raw_opponent_data = self.get_user_data(opponent)
      opponent_data = raw_opponent_data.map { |c,v| v }
    end
    opponent_data
  end

end
