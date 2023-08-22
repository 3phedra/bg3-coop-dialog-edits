function unlock_party_from_trade(trader1, trader2, trademode, var)
  --TODO look into what vars return
  --TODO Find out how to rip rest of party from dialog maybe DialogRequestStop(GUIDSTRING) or DialogRequestStopForDialog(DIALOGRESOURCE, GUIDSTRING)
  --This probably wont work:
  for character in elementIterator(db_party_struct["ActiveParty"]) do
    if character ~= trader1 then
      character_dialog = select(2, SpeakerGetDialog(character, 1))
      DialogRequestStopForDialog(character_dialog, character)
    end
  end
end
function defer_dialog_from_messagebox(var1, var2)
  return
  --TODO major todo
end
