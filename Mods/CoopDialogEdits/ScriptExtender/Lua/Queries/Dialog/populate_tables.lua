function populate_dialog_metadata(character_target, character_source)
  --Add all and controlled party members respectively

  --If distance preference is toggled, populate dbs only with characters within earshot
  if IsSpellActive(GetHostCharacter(), "DialogPreferenceDistance") ~= 1 then
    for _,entry in pairs(Osi.DB_Players:Get(nil)) do
      table.insert(db_party_all, entry[1])

      if IsControlled(entry[1]) == 1 then
        table.insert(db_party_players, entry[1])
        db_userids[GetReservedUserID(entry[1])] = entry[1]
      end
    end
  else
    for _,entry in pairs(Osi.DB_Players:Get(nil)) do
      if GetDistanceTo(character_target, entry[1]) <= 50.0 and GetRegion(entry[1]) == GetRegion(character_source) then
        table.insert(db_party_all, entry[1])

        if IsControlled(entry[1]) == 1 then
          table.insert(db_party_players, entry[1])
          db_userids[GetReservedUserID(entry[1])] = entry[1]
        end
      end
    end
  end

  --Add all camp followers to a table
  for _,entry in pairs(Osi.DB_PartOfTheTeam:Get(nil)) do
    table.insert(db_camp_characters, entry[1])
  end

  region_dlg = GetRegion(character_target)

  --TODO check what this even returns and if something better than "camp" can be used
  if string.find(region_dlg, "camp") then
    --Take into consideration whether the dialog region is the camp area
    is_region_camp = 1
  end

  --Store dialog starter character UserID
  userid_dlg_owner = GetReservedUserID(character_source)
  character_dlg_owner = character_source

  --Store dialog target character UserID
  userid_dlg_targetowner = GetReservedUserID(character_target)
  character_dlg_target = character_target

  return
end
