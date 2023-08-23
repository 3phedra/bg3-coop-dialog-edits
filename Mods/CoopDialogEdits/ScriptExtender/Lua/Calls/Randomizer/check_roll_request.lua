function check_reassignment_requested(character_target)
  --Check if reassignment is needed at all
  if db_dialog_methods["Method"] == "vanilla" or db_party_struct["RegionIsCamp"] then
    return false
  elseif has_value(db_party_struct["Camp"], character_target) then
    if db_dialog_methods["FollowerPreference"] then
      return true
    else
      return false
    end
  else
    return true
  end
end
