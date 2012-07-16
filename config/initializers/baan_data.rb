begin
 Rails.logger.info "Begin der Synchronisierung mit BAAN zur Ermittlung aller Drucker"
 Printer.synchronize_with_baan
 Rails.logger.info "Synchronisierung Drucker mit BAAN erfolgreich abgeschlossen"

 Rails.logger.info "Begin der Synchronisierung mit BAAN zur Ermittlung aller Kunden"
 Customer.synchronize_with_baan
 Rails.logger.info "Synchronisierung Kunden mit BAAN erfolgreich abgeschlossen"

#rescue ActiveRecord::StatementInvalid => e
# Rails.logger.error e.message
rescue Exception => e

 #Rails.logger.error e.message
 p e.message
 p e.backtrace
 #exit
end

