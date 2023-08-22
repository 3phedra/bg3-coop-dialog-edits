db_party_struct     = {}
db_dialog_methods   = {}
is_automated_dialog = 0
character_host      = "NULL_00000000-0000-0000-0000-000000000000"
mod_info            = ""
startTime           = 0
endTime             = 0
function cleanup()
  db_party_struct     = {}
  --TODO: Persist Fairness Mod and Win count!!
  --db_dialog_methods                   = {}
  is_automated_dialog = 0
  character_host      = "NULL_00000000-0000-0000-0000-000000000000"
  mod_info            = ""
  startTime           = 0
  endTime             = 0
end
