function reassign_follower(userid_new, userid_old, character_target)
	--Store the follower UUID and original follower owner for restoration
	userid_reassigned_follower_owner = userid_old
	character_reassigned_follower = character_target
	character_reassigned_follower_owner = db_userids[userid_old]
	--Temporarily assign follower to new owner for dialog
	AssignToUser(userid_new,character_target)

	return
end
