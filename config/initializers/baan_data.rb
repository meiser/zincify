 require 'informix'

 begin
  if Printer.all.empty?
   Rails.logger.info "Begin der Synchronisierung mit BAAN zur Ermittlung aller Drucker"
   Printer.synchronize_with_baan
   Rails.logger.info "Synchronisierung mit BAAN erfolgreich abgeschlossen"
  else
    Rails.logger.info "Druckerinitialisierung mit BAAN nicht notwendig"
  end

 rescue => e
   Rails.logger(e)
 end

