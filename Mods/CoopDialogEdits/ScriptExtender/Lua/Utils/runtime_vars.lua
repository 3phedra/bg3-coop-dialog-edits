db_party_players = {}
db_party_all = {}
db_camp_characters = {}
db_userids = {}
db_dialog_competitors = {}
db_count_dlg_roll_winner = {}
db_mod_dlg_roll_fairness = {}

is_automated_dialog = 0
was_follower_reassigned = 0
was_character_owner_reassigned = 0

userid_dlg_owner = 0
userid_dlg_new = 0
userid_dlg_targetowner = 0
userid_reassigned_follower_owner = 0
userid_follower_attached = 0
userid_dlg_reassigned_owner = 0

character_dlg_owner = "NULL_00000000-0000-0000-0000-000000000000"
character_dlg_new = "NULL_00000000-0000-0000-0000-000000000000"
character_dlg_targetowner = "NULL_00000000-0000-0000-0000-000000000000"
character_dlg_target = "NULL_00000000-0000-0000-0000-000000000000"
character_reassigned_follower_owner = "NULL_00000000-0000-0000-0000-000000000000"
character_reassigned_follower = "NULL_00000000-0000-0000-0000-000000000000"
character_dlg_owner_reassigned = "NULL_00000000-0000-0000-0000-000000000000"
character_dlg_roll_winner = "NULL_00000000-0000-0000-0000-000000000000"

function cleanup()
    db_party_players = {}
    db_party_all = {}
    db_userids = {}
    db_dialog_competitors = {}
    db_camp_characters = {}
    --db_count_dlg_roll_winner = {}
    --db_mod_dlg_roll_fairness = {}

    is_automated_dialog = 0
    was_follower_reassigned = 0
    was_character_owner_reassigned  = 0

    userid_dlg_owner = 0
    userid_dlg_new = 0
    userid_dlg_targetowner = 0
    userid_reassigned_follower_owner = 0
    userid_follower_attached = 0
    userid_dlg_reassigned_owner = 0

    character_dlg_owner = "NULL_00000000-0000-0000-0000-000000000000"
    character_dlg_new = "NULL_00000000-0000-0000-0000-000000000000"
    character_dlg_targetowner = "NULL_00000000-0000-0000-0000-000000000000"
    character_dlg_target = "NULL_00000000-0000-0000-0000-000000000000"
    character_reassigned_follower_owner = "NULL_00000000-0000-0000-0000-000000000000"
    character_reassigned_follower = "NULL_00000000-0000-0000-0000-000000000000"
    character_dlg_owner_reassigned = "NULL_00000000-0000-0000-0000-000000000000"
    character_dlg_roll_winner = "NULL_00000000-0000-0000-0000-000000000000"
end
