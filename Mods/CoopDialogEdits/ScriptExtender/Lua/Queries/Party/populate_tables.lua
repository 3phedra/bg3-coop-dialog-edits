function populate_dialog_metadata(character_target, character_source)
  --Add all and controlled party members respectively

  --TODO db_party_all can be expanded to contain UserID, IsControlled, Region and Distance data
  --but probably not much performance to be gained.

  --If distance preference is toggled, populate dbs only with characters within earshot
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDistance") ~= 1 then
    for _, character in pairs(Osi.DB_Players:Get(nil)) do
      table.insert(db_party_all, character[1])
      if IsControlled(character[1]) == 1 then
        table.insert(db_party_players, character[1])
        db_userids[GetReservedUserID(character[1])] = character[1]
      end
    end
  else
    for _, character in pairs(Osi.DB_Players:Get(nil)) do
      if GetDistanceTo(character_target, character[1]) <= 35.0 and GetRegion(character[1]) == GetRegion(character_source) then
        table.insert(db_party_all, character[1])
        if IsControlled(character[1]) == 1 then
          table.insert(db_party_players, character[1])
          db_userids[GetReservedUserID(character[1])] = character[1]
        end
      end
    end
  end

  --Add all camp followers to a table
  for _, entry in pairs(Osi.DB_PartOfTheTeam:Get(nil)) do
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
