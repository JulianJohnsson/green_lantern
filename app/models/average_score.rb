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
    static_scores = scores.where("kind = 0")
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
    avg_total = total / count
    avg_detail = [0,0,0,0,0]
    for i in 0..4
      avg_detail[i] = detail[i] / count
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

end
