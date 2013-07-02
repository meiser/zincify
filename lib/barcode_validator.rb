class BarcodeValidator < ActiveModel::Validator
 
  def validate(record)
    #record.errors.add :not_accepted, "" if record.released_date.future?
    # other record attributes you want to validate
	unless record.ref.present?
		unless MeiserBundleTag.where(:barcode => record.barcode).present?
			unless CustomerDelivery.where(:commission => record.barcode).present?
				unless CashPayerDelivery.where(:commission => record.barcode).present?
					record.errors.add :barcode, :not_accepted
				end
			end
		end
	end
  
  end
 
end