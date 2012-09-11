class BundleDataJob < Struct.new(:bundle_id, :date_of_scan)


  def perform

   p art = bundle_id[0,3]
   p load = bundle_id[3,9]
   p bund = bundle_id[12,3]

   #BaanTest
   #LOAD 001110613
   #update erp.twhmei002120 set t_dqua = t_dqua + :[int]p1 WHERE t_buid = :p2 AND t_orno = :p3 and t_pono = :p4
   #Meiser.foreach_baan("UPDATE ttibde915120 set t_wght = ? where t_load=? and t_bund=?", [121,load,bund]) do |e|
   # p e
   #endd


   #Meiser.foreach_baan("SELECT ttibde915120.* FROM ttibde915120 where t_load=? and t_bund=?", [load,bund]) do |e|
   # p e
   #end


   #update erp.twhmei002120 set t_dqua = t_dqua + :[int]p1 WHERE t_buid = :p2 AND t_orno = :p3 and t_pono = :p4
#   Baan.foreach_baan("select ttibde914120.t_cprj, ttdsls401120.t_pono, ttdsls401120.t_corn, ttdsls401120.t_corp, ttibde914120 .t_dqua, ttcibd001120.t_dsca, ttcibd001120.t_dscb, ttcibd001120.t_dscc from ttibde914120 inner join ttdsls401120 on ttibde914120.t_mitm = ttdsls401120.t_item inner join ttcibd001120 on ttcibd001120.t_item = ttdsls401120.t_item where t_load=? AND t_bund=?", sticker.verz_id) do |e|

   #Meiser.foreach_baan(" SELECT DBINFO('utc_to_datetime', sh_curtime) FROM sysmaster:sysshmvals;") do |e|
   # p e
   #end


   #Meiser.foreach_baan("SELECT COUNT(*) as total FROM ttczwf001120 where ttczwf001120.t_hstv=6") do |e|
   # p e
   #end and ttisfc001120.t_prdt = 2011-11-11 12:00:00.000000

   Meiser.foreach_baan("SELECT FIRST 10 ttisfc001120.t_pdno FROM ttisfc001120 inner join ttczwf001120 on  ttisfc001120.t_mitm = ttczwf001120.t_item where ttczwf001120.t_hstv=6 and ttisfc001120.t_osta=5 order by ttisfc001120.t_prdt ASC") do |e|
   p e
   end


  end





end

