class Match < ApplicationRecord

  after_create :notify_user

  scope :user_matches, -> (int) {where("user_id IS NULL OR user_id = ?", int)}

  def get_match_data(user)
    user_data = self.get_user_data(user)

    raw_user_data = user_data[1]
    user_total = user_data[0]
    opponent_data = self.get_opponent_data
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
    score = user.scores.last
    categories = Category.all.parent_categories.sort_by {|c| c.id}
    raw_user_total = score.total.to_f*1000/12
    raw_user_data = []
    for i in 0..4
      raw_user_data = raw_user_data << [categories[i], score.detail[i].to_f*1000/12]
    end
    return raw_user_total, raw_user_data
  end

  def get_opponent_data
    if self.data != []
      opponent_data = self.data
    else
      opponent = User.find(self.opponent_id)
      raw_opponent_data = self.get_user_data(opponent)[1]
      opponent_data = raw_opponent_data.map { |c,v| v }
    end
    opponent_data
  end

  def notify_user
    if self.user_id != nil
      UserMailer.new_match_ready(self).deliver_later
    end
  end

end
