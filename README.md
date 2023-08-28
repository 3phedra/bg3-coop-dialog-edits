# BG3 Coop Dialog Edits



## About

This mod is a heavily work-in-progress adjustment to multiplayer dialog handling in Baldurs Gate 3. Expect bugs, and potentially game-breaking ones at that! 

My intention was to make my own co-op sessions a little less chaotic since I found it quite the bother how chaotic things get when the party doesn't stick together at all times.

Features planned and present currently include

- [x] Force add all characters into a dialog at start.
  - [x] Optionally with distance/region limit.
- [x] Toggle random or skill (Charisma/Initiative roll) based dialog leadership.
   - [x] Optionally Exclude followers and camp.
   - [x] Opt in/out of randomized Dialog
- [x] Enable dialog with grouped followers for the non-owner.
- [x] Let specific characters make a claim to dialog ownership. (Semi-implemented via Opt-In feature)
- [ ] Check whether dialog target wants to talk to a particular player-controlled character
  - [ ] If so, ask to defer important or special dialogs to another player
- [ ] Hack the dialog system some more to function like in SWTOR.
  - Unfortunately, ongoing dialogs don't happen within the scope of the Osiris script system, so this depends on the necessary hooks being mapped in bg3se.

Larian pls.

## Requirements

This mod requires [BG3SE](https://github.com/Norbyte/bg3se) by Norbyte. 

Thank you Norbyte.

## Installation

Install the .pak however you usually install .paks, I recommend BG3MM. Or use the loose files directly in the Data directory.

<span style="color:red">**Installing this mod will make your savegame depend on the presence of [CoopDialog_Passives.txt](https://github.com/3phedra/bg3-coop-dialog-edits/blob/main/Public/CoopDialogEdits/Stats/Generated/Data/CoopDialog_Passives.txt) that is bundled with this mod. Without this file your save will not load.**</span>

I'll get around to sorting this out eventually.

## Usage

This will change a lot as I add more polish. At present, the host-controlled character will be given an ample amount of toggles:

- Dialog leadership determination methods (exclusive with one another):
  - Vanilla (Dialog starter leads dialog, but listeners will still be force-pulled in)
  - Random (Leadership is rolled amongst actively controlled characters)
  - Charisma (Same as Random, except taking charisma stat into account)
  - Initiative (Same as Charisma, except taking initiative stat into account)
- Mod preferences
  - Enable/Disable dialog hand-off when talking to follower NPCs
  - Enable/Disable mod features to 35 distance units. (Roughly translates to meters).
    - TODO: Make this a client preference
  - Enable/Disable leadership roll opt-in. 
    - Dialog leadership will only be determined amongst listeners who toggle the passive on their end
    - If noone opts in, dialog leadership falls back to vanilla method
    - If only one person opts in, they'll be the defacto overall dialog leader
  - Disable the mod and all of its features
    - TODO: Make this a client preference

## Todo

Short-to-midterm I will look for more appropriate icons for the toggles to be more easily distinguishable.
Further, I need to check which DB to query on whether a dialog target has special dialog with a party member.

Mid-dialog changes unfortunately require a lot more work on the side of BG3SE, so anything involving this is more of a long term todo.
