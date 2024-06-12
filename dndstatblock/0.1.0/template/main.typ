// ==========================================

#import "@preview/dndstatblock:0.1.0": *

#show: conf.with(
  header_left: "Typst Monster statblocks", 
  header_right: "Sample document", 
  footertext: [--Yanwenyuan--]
)


// ==========================================

#statheading("Snakecaller Acolyte", desc: "Medium humanoid, neutral evil")

#mainstats(ac: "10 (natural armour)", hp_dice: "2d8")

#ability(10, 10, 11, 10, 14, 11)

#skill("Skills", [Insight +4, Persuasion +2, Religion +2]) \
#skill("Senses", [Passive perception 12]) \
#skill("Languages", [Common, Snake-tongue]) \
#skill("Challenge", challenge(1))

#stroke()

=== Dark Devotion
The snakecaller acolyte has advantage on saving throws against being charmed or frightened.

=== Speak with Snakes
A snakecaller acolyte can speak with snakes within 30 ft., and can utter a one word command as an action. The snake must obey unless it would directly hurt itself.

=== Titanic Might 
As a bonus action, a snakecaller acolye can expend a spell slot to cause its melee weapon attacks to magically deal an extra #dice("3d6") poison damage to a target on hit. This benefit lasts until the end of the turn.

=== Spellcasting
A cult acolyte is a 2nd level spellcaster. Its spellcasting ability is wisdom (spell save DC 12, +4 to hit with spell attacks). It has the following spells prepared:

Cantrips (at will): _guidance, light, thaumaturgy_\
1st level (3 slots): _bane, cure wounds, guiding bolt, sanctuary_

== Actions 

=== Poison Dagger 
_Melee weapon attack:_ +2 to hit, reach 5 ft., one target. Hit: #dice("1d4") piercing damage. On a hit, the target must make a constitution saving throw (DC 12) and on a fail be poisoned.

_Adapted from: Cult Acolyte_
