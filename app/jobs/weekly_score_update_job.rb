class WeeklyScoreUpdateJob < ApplicationJob

  def perform
    @bridges = Bridge.all.to_sync
    @average = (Transaction.all.week.carbone_contribution.sum(:carbone) / Transaction.all.week.distinct.count(:user_id)).to_i
    require 'mailjet'
    Mailjet.configure do |config|
      config.api_key = Rails.application.credentials[:mailjet][:api_key]
      config.secret_key = Rails.application.credentials[:mailjet][:api_secret]
      config.default_from = 'emmanuel@hellocarbo.com'
      config.api_version = 'v3.1'
    end

    @bridges.each do |bridge|
      @user = bridge.user
      ReductionGeneratorJob.perform_later(@user)
      if @user.transactions.week.carbone_contribution.present? && @user.notification_preference.weekly_score_update == true
        @score = @user.transactions.week.carbone_contribution.sum(:carbone).round(0)
        @last_score = @user.transactions.previous_week.carbone_contribution.sum(:carbone).round(0)
        if @last_score == 0
          @variation = "#{(@score - @last_score).to_i} KGCO2 de plus"
        elsif @score > @last_score
          @variation = "#{(100*(@score - @last_score) / @last_score).to_i}% de plus"
        else
          @variation = "#{(-100*(@score - @last_score) / @last_score).to_i}% de moins"
        end

        case when @score > 150
          @equivalent = "La fabrication de #{(@score / 15).to_i} jeans 👖"
        when @score > 30
          @equivalent = "#{(@score / 5).to_i} burgers bien gras 🍔"
        else
          @equivalent = "#{(@score / 0.125).to_i}km en trotinette électrique 🛴"
        end

        carbone_by_category = Category.all.map{|c| [c.name, @user.transactions.week.category_id(c.id).sum(:carbone)]}.to_h
        @category = carbone_by_category.key(carbone_by_category.values.max)

        variable = Mailjet::Send.create(messages: [{
          'From'=> {
            'Email'=> "julien@hellocarbo.com",
            'Name'=> "Julien de Carbo"
          },
          'To'=> [
            {
              'Email'=> @user.email,
              'Name'=> (@user.name || "")
            }
          ],
          'TemplateID'=> 1163707,
          'TemplateLanguage'=> true,
          'Subject'=> "#{@user.name || "Hey"}, tu as généré #{@score} KGCO2 cette semaine",
          'Variables'=> {
            "score" => @score,
            "name" => (@user.name || ""),
            "variation" => @variation,
            "equivalent" => @equivalent,
            "category" => @category,
            "average" => @average
          }
        }])
        p variable.attributes['Messages']
      end
    end
  end

end
