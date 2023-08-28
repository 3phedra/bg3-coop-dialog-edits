function unlock_party_from_trade(trading_character)
  for character in elementIterator(db_party_struct["ActiveParty"]) do
    if character ~= trading_character then
      DialogRemoveActorFromDialog(db_dialog_struct["DialogID"], character)
    end
  end
end
