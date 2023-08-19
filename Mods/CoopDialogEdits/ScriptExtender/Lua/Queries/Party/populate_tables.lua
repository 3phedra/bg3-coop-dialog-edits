function populate_dialog_metadata(character_target, character_source)
  --Add all and controlled party members respectively

  --TODO db_party_all can be expanded to contain UserID, IsControlled, Region and Distance data
  --but probably not much performance to be gained.

  --If distance preference is toggled, populate dbs only with characters within earshot

  local event_name = "populate_dialog_metadata"
  local event_state = "check_passive_distance"
  local event_operation = "IsSpellActive"
  local event_args = GetHostCharacter() .. ", " .. "DialogPreferenceDistance"
  local event_data = IsSpellActive(GetHostCharacter(), "DialogPreferenceDistance")

  print_log(event_name, event_state, event_operation, event_args, event_data)

  if IsSpellActive(GetHostCharacter(), "DialogPreferenceDistance") ~= 1 then
    for _, entry in pairs(Osi.DB_Players:Get(nil)) do
      table.insert(db_party_all, entry[1])

      event_name = "populate_dialog_metadata"
      event_state = "iterate_no_distance: " .. entry[1]
      event_operation = "table.insert"
      event_args = "db_party_all" .. ", " .. entry[1]
      event_data = dump_table(db_party_all)

      print_log(event_name, event_state, event_operation, event_args, event_data)

      if IsControlled(entry[1]) == 1 then
        table.insert(db_party_players, entry[1])

        event_name = "populate_dialog_metadata"
        event_state = "iterate_no_distance: " .. entry[1]
        event_operation = "table.insert"
        event_args = "db_party_players" .. ", " .. entry[1]
        event_data = dump_table(db_party_players)

        print_log(event_name, event_state, event_operation, event_args, event_data)

        db_userids[GetReservedUserID(entry[1])] = entry[1]

        event_name = "populate_dialog_metadata"
        event_state = "iterate_no_distance: " .. entry[1]
        event_operation = "db_userids[GetReservedUserID(entry[1])] = entry[1]"
        event_args = entry[1] .. ", " .. GetReservedUserID(entry[1])
        event_data = dump_table(db_userids)

        print_log(event_name, event_state, event_operation, event_args, event_data)
      end
    end
  else
    for _, entry in pairs(Osi.DB_Players:Get(nil)) do
      if GetDistanceTo(character_target, entry[1]) <= 35.0 and GetRegion(entry[1]) == GetRegion(character_source) then
        table.insert(db_party_all, entry[1])
        if IsControlled(entry[1]) == 1 then
          table.insert(db_party_players, entry[1])
          db_userids[GetReservedUserID(entry[1])] = entry[1]
        end
      end
    end
  end

  --Add all camp followers to a table
  for _, entry in pairs(Osi.DB_PartOfTheTeam:Get(nil)) do
    table.insert(db_camp_characters, entry[1])
  end

  event_state = "check_camp_npc"
  event_operation = "Osi.DB_PartOfTheTeam:Get"
  event_args = "nil"
  event_data = dump_table(db_camp_characters)

  print_log(event_name, event_state, event_operation, event_args, event_data)

  region_dlg = GetRegion(character_target)

  --TODO check what this even returns and if something better than "camp" can be used
  if string.find(region_dlg, "camp") then
    --Take into consideration whether the dialog region is the camp area
    is_region_camp = 1
  end

  event_state = "check_region_is_camp"
  event_operation = "string.find"
  event_args = "camp" .. ", " .. region_dlg
  event_data = is_region_camp

  print_log(event_name, event_state, event_operation, event_args, event_data)

  --Store dialog starter character UserID
  userid_dlg_owner = GetReservedUserID(character_source)
  character_dlg_owner = character_source

  event_state = "get_caller_id"
  event_operation = "GetReservedUserID"
  event_args = character_source
  event_data = userid_dlg_owner

  print_log(event_name, event_state, event_operation, event_args, event_data)

  --Store dialog target character UserID
  userid_dlg_targetowner = GetReservedUserID(character_target)
  character_dlg_target = character_target

  event_state = "get_target_owner_id"
  event_operation = "GetReservedUserID"
  event_args = character_target
  event_data = userid_dlg_owner

  print_log(event_name, event_state, event_operation, event_args, event_data)

  return
end
