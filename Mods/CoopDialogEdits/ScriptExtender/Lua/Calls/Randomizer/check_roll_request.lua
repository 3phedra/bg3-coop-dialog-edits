function check_reassignment_requested(character_target)
  --Check if reassignment is needed at all
  if db_dialog_methods["Method"] == "vanilla" or db_dialog_struct["RegionIsCamp"] then
    return false
  else
    return true
  end
end
