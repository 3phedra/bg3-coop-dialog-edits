function attach_character(userid, character)
  SetOnStage(character, 1)
  return
  --MakePlayer(character)
  --Make sure character is assigned to correct user (shouldn't be necessary but for safety)
  --AssignToUser(userid,character)
  --Force making character controlled again
  --MakePlayerActive(character)
end
function attach_follower(userid, character_target, follower)
  AssignToUser(userid, follower)
  AttachToPartyGroup(follower, character_target)
end
