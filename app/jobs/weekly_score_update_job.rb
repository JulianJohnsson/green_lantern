class WeeklyScoreUpdateJob < ApplicationJob

  def perform
    @bridges = Bridge.all.to_sync
    average = (Transaction.all.week.carbone_contribution.sum(:carbone) / Transaction.all.week.distinct.count(:user_id)).round(0)

    @bridges.each do |bridge|
      user = bridge.user
      if user.transactions.week.carbone_contribution.present? && user.notification_preference.weekly_score_update == true
        score = user.transactions.week.carbone_contribution.sum(:carbone).round(0)
        last_score = user.transactions.previous_week.carbone_contribution.sum(:carbone).round(0)
        if score > last_score
          variation = "#{(100*(score - last_score) / last_score).to_i}% de plus"
        else
          variation = "#{(-100*(score - last_score) / last_score).to_i}% de moins"
        end

        case when score > 150
          equivalent = "La fabrication de #{(score / 15).round(0)}jeans 👖"
        when score > 30
          equivalent = "#{(score / 5).round(0)}burgers bien gras 🍔"
        else
          equivalent = "#{(score / 0.202).round(0)}km en trotinette électrique 🛴"
        end

        carbone_by_category = Category.all.map{|c| [c.name, user.transactions.week.category_id(c.id).sum(:carbone)]}.to_h
        category = carbone_by_category.key(carbone_by_category.values.max)

        variable = Mailjet::Send.create(messages: [{
          'From'=> {
            'Email'=> "emmanuel@hellocarbo.com",
            'Name'=> "Emmanuel de Carbo"
          },
          'To'=> [
            {
              'Email'=> user.email,
              'Name'=> user.name || ""
            }
          ],
          'TemplateID'=> 1163707,
          'TemplateLanguage'=> true,
          'Subject'=> "#{user.name}, tu as généré #{score} KGCO2 cette semaine",
          'Variables'=> {
            "score" => score,
            "name" => user.name,
            "variation" => variation,
            "equivalent" => equivalent,
            "category" => category,
            "average" => average
          }
        }])
        p variable.attributes['Messages']
      end
    end
  end

end
