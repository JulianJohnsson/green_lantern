class AverageScore < ApplicationRecord
  enum score_kind: [:static, :dynamic]

  def self.create_average(date)
    month_scores = Score.where("updated_at >= ? AND updated_at < ?", date - 1.month, date)
    year_scores = Score.where("updated_at >= ? AND updated_at < ?", date - 1.year, date)

    avg_static = AverageScore.new
    avg_static.score_kind = "static"
    avg_static.year_total = avg_static.set_static_average(year_scores)[0]
    avg_static.year_detail = avg_static.set_static_average(year_scores)[1]
    avg_static.month_total = avg_static.set_static_average(month_scores)[0]
    avg_static.month_detail = avg_static.set_static_average(month_scores)[1]
    avg_static.save

    avg_dynamic = AverageScore.new
    avg_dynamic.score_kind = "dynamic"
    avg_dynamic.year_total = avg_dynamic.set_dynamic_average(date)[0]
    avg_dynamic.year_detail = avg_dynamic.set_dynamic_average(date)[1]
    avg_dynamic.month_total = avg_dynamic.set_dynamic_average(date)[2]
    avg_dynamic.month_detail = avg_dynamic.set_dynamic_average(date)[3]
    avg_dynamic.save

  end

  def set_static_average(scores)
    static_scores = scores.where("kind = 0 AND total < 30")
    total = 0
    count = 0
    detail = [0,0,0,0,0]
    static_scores.each do |score|
      total = total + score.total
      count = count + 1
      for i in 0..4
        detail[i] = detail[i] + score.detail[i].to_f
      end
    end
    if count > 0
      avg_total = total / count
      avg_detail = [0,0,0,0,0]
      for i in 0..4
        avg_detail[i] = detail[i] / count
      end
    else
      avg_total = 0
      avg_detail = [0,0,0,0,0]
    end
    return avg_total, avg_detail
  end

  def set_dynamic_average(date)
    dynamic_scores = Score.where("kind = 1 and created_at <= ?", date)

    total = 0
    count = 0
    detail = [0,0,0,0,0]
    recent_total = 0
    recent_count = 0
    recent_detail = [0,0,0,0,0]

    dynamic_scores.each do |score|
      total = total + score.total
      count = count + 1
      for i in 0..4
        detail[i] = detail[i] + score.detail[i].to_f
      end
      if score.recent_total > 0
        recent_total = recent_total + score.recent_total
        recent_count = recent_count + 1
        for i in 0..4
          recent_detail[i] = recent_detail[i] + score.recent_detail[i].to_f
        end
      end
    end
    avg_total = total / count
    avg_recent_total = recent_total / recent_count
    avg_detail = [0,0,0,0,0]
    avg_recent_detail = [0,0,0,0,0]
    for i in 0..4
      avg_detail[i] = detail[i] / count
      avg_recent_detail[i] = recent_detail[i] / recent_count
    end
    return avg_total, avg_detail, avg_recent_total, avg_recent_detail
  end

  # to retrieve history before scheduled jobs where launched to calculate it each week
  def self.dynamic_history(date)
    scores = Score.where("kind = 1 and created_at <= ?", date)

    total = 0
    count = 0
    detail = [0,0,0,0,0]
    categories = [1,12,24,25,70]

    scores.each do |score|
      transactions = score.user.transactions.where("date > ? AND date <= ?", date - 1.month, date).carbone_contribution
      total = total + transactions.sum(:carbone)
      count = count + 1
      for i in 0..4
        detail[i] = detail[i] + transactions.where("parent_category_id = ?", categories[i]).sum(:carbone)
      end
    end
    avg_total = total / count * 12 / 1000
    avg_detail = [0,0,0,0,0]
    for i in 0..4
      avg_detail[i] = detail[i] / count * 12 / 1000
    end
    AverageScore.create(score_kind: 1, month_total: avg_total, month_detail: avg_detail, created_at: date)
  end

  # to update a dynamic average if many transactions carbone impact have been updated
  def update_month_history
    scores = Score.where("kind = 1 and created_at <= ?", self.created_at)

    total = 0
    count = 0
    detail = [0,0,0,0,0]
    categories = [1,12,24,25,70]

    scores.each do |score|
      transactions = score.user.transactions.where("date > ? AND date <= ?", self.created_at - 1.month, self.created_at).carbone_contribution
      total = total + transactions.sum(:carbone)
      if transactions.sum(:carbone) > 0
        count = count + 1
      end
      for i in 0..4
        detail[i] = detail[i] + transactions.where("parent_category_id = ?", categories[i]).sum(:carbone)
      end
    end
    avg_total = total / count * 12 / 1000
    avg_detail = [0,0,0,0,0]
    for i in 0..4
      avg_detail[i] = detail[i] / count * 12 / 1000
    end
    self.month_total = avg_total
    self.month_detail = avg_detail
    self.save
  end

  def update_week_history
    scores = Score.where("kind = 1 and created_at <= ?", self.created_at)

    total = 0
    count = 0
    detail = [0,0,0,0,0]
    categories = [1,12,24,25,70]

    scores.each do |score|
      transactions = score.user.transactions.where("date > ? AND date <= ?", self.created_at - 1.week, self.created_at).carbone_contribution
      total = total + transactions.sum(:carbone)
      if transactions.sum(:carbone) > 0
        count = count + 1
      end
      for i in 0..4
        detail[i] = detail[i] + transactions.where("parent_category_id = ?", categories[i]).sum(:carbone)
      end
    end
    avg_total = total / count * 12 / 1000
    avg_detail = [0,0,0,0,0]
    for i in 0..4
      avg_detail[i] = detail[i] / count * 12 / 1000
    end
    self.week_total = avg_total
    self.week_detail = avg_detail
    self.save
  end

end
