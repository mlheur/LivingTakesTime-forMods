Here is a... "patch" by dragonsong, of the mod Living Takes Time (aka Reading Takes Time) by Akezhar.

This is a set of REPLACEMENT files, not a patch in the sense of a modular ESP, because I wanted to change some core functionality of LTT, in order to provide fine-tune values for craftable items in various mods:
 - Frostfall
 - Realistic Needs and Diseases
 - Hunterborn, my own mod
 - Wearable Lantern
 - Lanterns and Candles

By default, LTT will classify most of the items crafted by these mods as "misc", a very broad category that has only one setting in LTT's MCM, which is 2 hours by default. So, crafting a torch in Frostfall, or a Cache Marker in Hunterborn, or the Travel Lantern from Wearable Lantern, or any of the candles in LaC, will all take 2 hours. Giving them all categories and specific settings in the MCM required modifying the original scripts. (But not the original ESP. You read that right. No masters required! All of the items are dynamically referenced in the scripts.)

The RND module also has different settings for eating different size meals, and drinks. These key off of any food / drink that has an RND effect, so it also works with Hunterborn's RND patched foods, or any other mod's foods if they're patched for RND.

I made a few other changes to the core mod itself, too. For starters, I added a feature I've wanted for a really long time: In the Looting category, there are now settings for looting light and heavy armor. No longer will you strip that bandit corpse naked of his bloodied plate armor in no time at all - better to consider if the weight *and* the time are worth it, now. (However, as a side-effect, looting armor from non-humanoids like dragons will have the same time cost.) This only applies to armor with the "cuirass" keyword, not boots or helms or gloves or any armor from a mod that is not using correct keywords.

There's also a hotkey to suspend or resume the mod completely.

I also changed how crafting potions works. Instead of summarizing your work when you exit the crafting station, each crafted potion takes time as soon as you craft it. This was necessary because of support for all of the mods above, plus it also flows a little better, I think. I'm thinking of a way to make the time less or more depending on the potion's power, but this is difficult to determine since fBarterMin/Max can be changed, so the "value" of a potion isn't on a fixed scale.

I added a lot of debugging to the Papyrus log, but I may take this out, since it's pretty spammy and most people won't need it.

To "install" this patch, simply drop the PEX files into your Data\Scripts folder. They are designed to (probably) work even without a clean save. The source PSC files are optional, or for modder use and reference.

-- DISCLAIMER --

This is a quick and dirty implementation that is not intended for broad public use. It hasn't got a lot of polish or playtesting. I cannot promise any support if it has bugs or breaks your game, sorry. :(  If you've got questions or want to take the work and clean it up for release on Nexus, just PM me there. My handle is unuroboros.

-- CHANGELOG --

v12: Included with Hunterborn 1.4.4. Changed the threshold for a time passing message to be at least 10 minutes. Fixed times for Frostfall's arrows and stone hatchet, and changed some FF defaults. Hunterborn arrows get their own timer / setting. And removed the time cost for HB's hunter's cache.

v11: Included with Hunterborn 1.4.3. Additional ammo and food bugfixes related to very lightweight objects (Fork of Damnation... sigh!).

v10: Included with Hunterborn 1.4.1. Fixes ammo crafted at the forge (took no time, previously), and now ignores very small items (like the Fork of Damnation, sigh) for item-added and item-removed events. Also better identifies smelting, which can include meltdown, but there is still only a single category / time for smelting, which is the Crafting - Misc time. This isn't really a technical limitation, but for simplicity. Note that FISS support for all of the new timers in this patch is still missing / todo.
