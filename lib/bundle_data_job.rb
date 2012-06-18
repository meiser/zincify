class BundleDataJob < Struct.new(:deliver_references)

  def perform

   db = Informix.connect(ENV["INFORMIXSERVER"], ENV["INFORMIXUSER"], ENV["INFORMIXPWD"])

   deliver_references.each do |ref|

    db.transaction do |db|
     db.foreach_hash("SELECT t_load, t_bund FROM ttibde914120 WHERE t_load=?", :params =>[ref.name]) do |r|
      unless ref.content.bundle
       ref.content.bundle = []
      end
      ref.content.bundle << "003"+r["t_load"].strip+r["t_bund"].rstrip
      ref.content.bundle.uniq!
      ref.save
     end
    end

   end

  end

end

