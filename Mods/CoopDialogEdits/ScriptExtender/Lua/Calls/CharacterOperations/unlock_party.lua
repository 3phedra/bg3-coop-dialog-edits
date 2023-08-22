function unlock_party_from_trade(trading_character)
  for character in elementIterator(db_party_struct["ActiveParty"]) do
    if not character == trading_character then
      DialogRemoveActorFromDialog(db_party_struct["DialogID"], character)
    end
  end
end
