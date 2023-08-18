function register_passive_spell()
	--TODO What do the args mean?
	AddBoosts(GetHostCharacter(), "", "", "")
	--TODO add only when no dialog passive found
	AddPassive(GetHostCharacter(), "CoopDialogOwner")
end
