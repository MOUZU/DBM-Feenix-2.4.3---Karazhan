#DBM Feenix 2.4.3 - Karazhan
I worked on adjusting the DBM Timers for Feenix 2.4.3 Archangel Server in my time playing on there, since I've stopped doing so there will most likely be not that much of a progress from now on but feel free to keep working on my code or at least report Issues here on GitHub (if you support enough Material for me to fix things without playing myself I might do that).

<br \>
<a href="https://github.com/MOUZU/DBM-Feenix-2.4.3---Karazhan/releases">Download latest Release</a><br \>
<a href="http://www.wow-one.com/forum/topic/94594-243-dbm-adjusted-for-feenix/">WOW-ONE.com Forum Thread</a>

#Changelist
For people who aren't into coding and doesn't want to check the Changes in Detail I'll list here the major changes made prior to this first GitHub upload:

Attumen:
- added a trigger for when Attumen spawns and an alert saying "*** Attumen spawned ***"
- fixed the locale for phase triggering to p2 from "Come Midnight, [...]" to "Come, Midnight, [...]"
- added Charge Timer (20s) in p2 (will start 2s after phase triggering)
- the curse timer will now start 30s after attumen spawned, and lowered the duration for other timers from 41s to 30s
- added an announcement for p2 "*** Last Phase ***"

Moroes:
- fixed the combat trigger locale from "Hm, unannounced visitors. Preparations must be made..." to "Hmm, unannounced visitors? Preparations must be made."
- added locales to trigger when he is back(from vanish)
- changed the value for the first vanish from 33s to 29.5s, for the other vanishes to 30s
- added a timer for when he is vanished to display when vanish will fade(after 12s) ( it doesnt trigger )

Maiden:
- added (synced) Next Holy Fire Timer (seems to be every 8s)
- fixed the localization which triggers the fight from "[...] tolerated." to "[...] tolerated!"
- changed the timer for the first repentance from 40s to 26s

Opera RJ: (untested)
- fixed the Combat Trigger
- added a Timer for Powerful Attraction (6s, that is the stun)

Opera BBW: (untested)
- fixed the combat trigger from " The better [...]" to "All the better [...]"
- added a timer for the first red riding hood

Opera OZ: (untested)
- fixed the locale to trigger the fight
- changed the Timer of Roar from 14.5 to 17s
- changed the Timer of Strawman from 24 to 28s
- changed the Timer of Tinhead from 33 to 41s
- added a Timer for Dorothee 12.5s
- added/fixed few locales
- made the Timers only appear when the last one has expired/mob spawned. We dont want to many up at a time
- added a Timer for the crone itself, 9s after emote

Curator:
- lowered the first Evocation Timer from 109 to 100.5s
- added a timer for the Flare Spawn (every 10s)
- the second Evocation timer will now only be visible after the first evo finished

Illhoof:
- changed the locale to trigger the combat from "[...] begin!" to "[...] begin."
- added a Timer for when Kilrek (the giant imp) spawns (after 5s)
- added a Timer & warning for the first Sacrifice (30s)
- changed the timer for the other Sacrifice alerts from 44s to 30s
- fixed the weakened timer and changed its duration from 31s to 45s ( wont work atm, since Kilreks Death does not trigger)

Aran:
- added 3 yells he does on pull to the english localization and added combatstart()
- added a timer for the arcane explosions (every 70s) (didnt seem to match, lowered to 30s but can not be accurate )

Prince:
- increased the Infernal Timer from 40 to 45s in P1&P2, and from 22.5 to 18s in P3
- if he makes his Infernal emote the Infernal Timer will reset to 4s left (instead of 22.5s and 4s)
- added a Timer to display the next Enfeeble (every 30s)
- added a Timer to display the next Shadow Nova (after 34s, every 30s)
- triggering next timers got overhauled, values got adjusted to lower the DBM timers active at a time
- fixed the locales for phase3 triggering to "I see the subtlety of conception is beyond primitives such as you."
- Infernal timer will reset on p3 entering, next infernal comes in ~15s

Nightbane: (untested)
- added a timer for the first Fear
- added a timer for "adds spawning" 13s after air phase begins
- added a timer for how long adds are spawning which seems to be 10s
- tried a new trigger for the fear
- added a timer for the breaths, seems to be 8s the first one and every 40s after
- added a timer for Charred Earth, after 13s every 20s
