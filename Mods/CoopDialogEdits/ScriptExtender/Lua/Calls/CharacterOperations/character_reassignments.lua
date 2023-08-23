function detach_character(character)
  db_party_struct[character]["WasDetached"] = true
  db_party_struct["DetachedPlayer"] = character
  --TODO listeners set off stage get a weird echo in dialogs. Find a better method. Again. :(
  --Something hacky with an ungrouped NPC perhaps...
  --MakePlayer(SomeTotalNobody)
  --AssignToUser(db_party_struct[character]["UserID"],SomeTotalNobody)
  --Might work idk??
  --What about DialogRemoveActorFromDialog(INTEGER, GUIDSTRING) followed by DialogAddActor(INTEGER, GUIDSTRING)
  --Or SpeakerGetDialog(GUIDSTRING, INTEGER, DIALOGRESOURCE, INTEGER)
  --Or DialogRequestStop(Speaker), DialogRequestStopForDialog(Dialog, Speaker) or DialogResume(InstanceID)
  --What is DualDialogStart(Dialog, InstanceID)
  --What about setting the target off stage, then onstage and restart manually?
  --Maybe SharedTurnBaseMode(CHARACTER, INTEGER) gets rid of shared turns
  SetOnStage(character, 0)
  return
end
function reassign_follower(userid_new, character_target)
  db_party_struct[character_target]["OrigOwnerUserID"] = db_party_struct[character_target]["UserID"]
  db_party_struct[character_target]["OrigOwnerCharacter"] = db_party_struct
      [db_party_struct[character_target]["OrigOwnerUserID"]]
  db_party_struct[character_target]["WasReassigned"] = true
  db_party_struct["FollowerReassigned"] = character_target
  AssignToUser(userid_new, character_target)
  return
end
function attach_character()
  if db_party_struct["DetachedPlayer"] ~= nil then
    SetOnStage(db_party_struct["DetachedPlayer"], 1)
    db_party_struct[db_party_struct["DetachedPlayer"]]["WasDetached"] = false
    db_party_struct["DetachedPlayer"] = nil
  end
  return
  --MakePlayer(character)
  --Make sure character is assigned to correct user (shouldn't be necessary but for safety)
  --AssignToUser(userid,character)
  --Force making character controlled again
  --MakePlayerActive(character)
end
function attach_follower()
  if db_party_struct["FollowerReassigned"] ~= nil then
    local target = db_party_struct["FollowerReassigned"]
    local target_owner = db_party_struct[target]["OrigOwnerUserID"]
    local owner_character = db_party_struct[target]["OrigOwnerCharacter"]
    AssignToUser(db_party_struct[target]["OrigOwnerUserID"], target)
    AttachToPartyGroup(target, owner_character)
  end
end
