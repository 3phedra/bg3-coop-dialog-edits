function detach_character(userid,character)
	--Store UserID for player character about to be detached from player
	userid_dlg_reassigned_owner = userid
	character_dlg_owner_reassigned = character
	--Temporarily detach character from player for dialog reassignment
	--TODO Find a better method, this will break the game if player is not in control of a second character
	--MakeNPC(character)
	SetOnStage(character,0)
	was_character_owner_reassigned = 1
	return
end
