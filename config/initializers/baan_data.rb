require 'informix'

begin
  unless Printer.first
  Rails.logger.info "Begin der Synchronisierung mit BAAN zur Ermittlung aller Drucker"
  Printer.synchronize_with_baan
  Rails.logger.info "Synchronisierung mit BAAN erfolgreich abgeschlossen"
 else
   Rails.logger.info "Druckerinitialisierung mit BAAN nicht notwendig"
 end

 unless Customer.first
  Customer.synchronize_with_baan
 end

rescue => e
 Rails.logger(e)
end

