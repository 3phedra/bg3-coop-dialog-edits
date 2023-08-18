Ext.Require("Utils/custom_std.lua")

function roll_for_dialog(method,characters)

	local roll_winner

	--TODO Add more methods
	if method == "random" then
		--Add all dialog competitors and their respective random roll to a table
		for character in elementIterator(characters) do
		    if db_mod_dlg_roll_fairness[character] == nil then
	        db_mod_dlg_roll_fairness[character] = 0
        end
			--db_dialog_competitors.insert(Random(20) + 1,character)
			--TODO check how to utilize RequestPassiveRoll or RequestPassiveRollVersusSkill
			db_dialog_competitors[character] = Random(20) + 1 + db_mod_dlg_roll_fairness[character]
		end
	elseif method == "charisma" then
		for character in elementIterator(characters) do
			local modifier = GetAbility(character, "Charisma")
			modifier = (-10 + modifier) / 2
			db_dialog_competitors[character] = Random(20) + 1 + modifier + db_mod_dlg_roll_fairness[character]
		end
	elseif method == "initiative" then
		for character in elementIterator(characters) do
			local modifier = GetAbility(character, "Initiative")
			modifier = (-10 + modifier) / 2
			db_dialog_competitors[character] = Random(20) + 1 + modifier + db_mod_dlg_roll_fairness[character]
		end
	elseif method == "vanilla" then
		print("Why was this code reached???")
	end

	--Sort competitor table lowest to highest roll and pick the last entry as winner
	for character,roll_result in spairs(db_dialog_competitors, function(t,a,b) return t[b] > t[a] end) do
		roll_winner = character
	end

	return roll_winner
end
