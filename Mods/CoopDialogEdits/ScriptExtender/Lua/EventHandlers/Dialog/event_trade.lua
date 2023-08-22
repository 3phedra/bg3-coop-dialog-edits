Ext.Require("Calls/CharacterOperations/unlock_party.lua")

function trade_request(trade_source, trade_target)
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    return
  end
  unlock_party_from_trade(trade_source)
  return
end
