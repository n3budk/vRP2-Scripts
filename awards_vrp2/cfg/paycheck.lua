local cfg = {}

-- paycheck and bill for users
cfg.message_paycheck = "Registered Citizen Cash Bonus: ~g~$" -- message that will show before payment of salary
cfg.message_bill = "You paid your taxes: ~r~$" -- message that will show before payment of bill


cfg.minutes_paycheck = 25 -- minutes between payment for paycheck
cfg.minutes_prize = 62 -- minutes between withdrawal for bill
cfg.minutes_police = 15 -- minutes between withdrawal for bill
cfg.minutes_ems = 15 -- minutes between withdrawal for bill

cfg.paycheck_title_picture = "AllCity Bonus" -- define title for paycheck notification picture
cfg.paycheck_picture = "CHAR_FILMNOIR" -- define paycheck notification picture want's to display
cfg.bill_title_picture = "AllCity Bonus" -- define title for bill notification picture
cfg.bill_picture = "CHAR_FILMNOIR" -- define bill notification picture want's to display

cfg.paycheck = { 
  ["citizen.paycheck"] = 1500

}

cfg.prize = { 
  ["citizen.paycheck"] = 150

}

cfg.police = { 
  ["police.key"] = 150

}

cfg.ems = { 
  ["ems.whitelisted"] = 150

}
return cfg
