function detach_character(character)
  db_party_struct[character]["WasDetached"] = true
  db_party_struct["DetachedPlayer"] = character
  SetOnStage(character, 0)
  return
end
function reassign_follower(userid_new, character_target)
  db_party_struct[character_target]["OrigOwnerUserID"] = db_party_struct[character_target]["UserID"]
  db_party_struct[character_target]["OrigOwnerCharacter"] = db_party_struct[character_target]
  db_party_struct[character_target]["WasReassigned"] = true
  db_party_struct["Reassigned_Follower"] = character_target
  AssignToUser(userid_new, character_target)
end
function attach_character()
  if db_party_struct["DetachedPlayer"] ~= nil then
    SetOnStage(db_party_struct["DetachedPlayer"], 1)
  end
  return
  --MakePlayer(character)
  --Make sure character is assigned to correct user (shouldn't be necessary but for safety)
  --AssignToUser(userid,character)
  --Force making character controlled again
  --MakePlayerActive(character)
end
function attach_follower()
  if db_party_struct["Reassigned_Follower"] ~= nil then
    AssignToUser(db_party_struct[follower]["OrigOwnerUserID"], db_party_struct["Reassigned_Follower"])
    AttachToPartyGroup(db_party_struct["Reassigned_Follower"], db_party_struct[character_target]["OrigOwnerCharacter"])
  end
end
