class ClassifierJob < ApplicationJob

  def perform
    transactions = Transaction.all.where("description is not null and category_id is not null")
    @lsi = ClassifierReborn::LSI.new(auto_rebuild: false)
    transactions.each { |x| @lsi.add_item("cb " + x.description, x.category_id) }
    @lsi.build_index

    classifier_snapshot = Marshal.dump @lsi
    # This is a string of bytes, you can persist it anywhere you like
    File.open("classifier.dat", "w:ASCII-8BIT") {|f| f.write(classifier_snapshot) }
  end

end
