function check_reassignment_requested(character_target)
	--Check if reassignment is needed at all
	--TODO Add more methods

	if HasActiveStatus(GetHostCharacter(), "COOPDIALOGVANILLA") == 1 then
	    return false
    end

	if has_value(db_camp_characters,character_target) then
		if HasActiveStatus(GetHostCharacter(), "COOPDIALOGFOLLOWERS") == 0 then
			return false
		end
	end

	if HasActiveStatus(GetHostCharacter(), "COOPDIALOGRANDOM") == 1 or HasActiveStatus(GetHostCharacter(), "COOPDIALOGCHARISMA") == 1 then
		reassignment_requested = true
    else
        reassignment_requested = false
	end

	return reassignment_requested
end
