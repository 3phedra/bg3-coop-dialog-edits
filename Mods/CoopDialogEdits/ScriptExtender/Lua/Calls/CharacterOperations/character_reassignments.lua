function detach_character(character)
  db_party_struct[character]["WasDetached"] = true
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

  --TODO: DOES NOT WORK ANYMORE WTF
  SetOnStage(character, 0)
  return
end
function reassign_follower(userid_new, character_target)
  db_party_struct[character_target]["WasReassigned"] = true
  AssignToUser(userid_new, character_target)
  return
end
function attach_character()
  for character in elementIterator(db_party_struct["ActiveParty"]) do
    if db_party_struct[character]["WasDetached"] then
      SetOnStage(character, 1)
      db_party_struct[character]["WasDetached"] = false
    end
  end
  return
  --MakePlayer(character)
  --Make sure character is assigned to correct user (shouldn't be necessary but for safety)
  --AssignToUser(userid,character)
  --Force making character controlled again
  --MakePlayerActive(character)
end
function attach_follower()
  for character in elementIterator(db_party_struct["ActiveParty"]) do
    if db_party_struct[character]["WasReassigned"] then
      local owner = db_party_struct[character]["UserID"]
      AssignToUser(owner, character)
      for char in elementIterator(db_party_struct["ActiveParty"]) do
        if db_party_struct[character]["UserID"] == db_party_struct[char]["UserID"] and db_party_struct[char]["IsPlayer"] then
          AttachToPartyGroup(character, char)
        end
      end
      db_party_struct[character]["WasReassigned"] = false
    end
  end
end
