# PlayerSpeech
PlayerSpeech is a World of Warcraft addon to change a character's error speech lines to any of the other playable races. It uses only already existing game files. It only plays for events such as "Out of range" and has no impact on what other sounds your character makes.

## Motivation
Dracthyr have been impacted for a long time to be "muted" while in their dragon form. The initial version of this addon only covered to fix this and play their audio again. This new version makes it more versatile for everyone to choose their preferred voice, e.g. Demon Hunter sounds over you regular elf voice.

## Features
Includes all playable races including the different voices of Demon Hunters, Dracthyr, Visage, and Gilnean (Worgen Human form). You can freely switch between male and female as well.

## Custom Voices
You can add your own voice lines with the `PlayerSpeech_Custom` companion addon. It is a separate addon so your sound files are never lost when PlayerSpeech updates.

1. Download `PlayerSpeech_Custom.zip` from the [latest release](https://github.com/exruos/PlayerSpeech/releases/latest) and extract it into your `Interface\AddOns` folder next to PlayerSpeech.
2. Put your `.ogg` or `.mp3` files into `PlayerSpeech_Custom\sounds`.
3. Open `Voice.lua` and uncomment the errors you have sounds for, adjusting the file names if needed.
4. Restart the game completely. WoW only finds new sound files after a restart, `/reload` is not enough.
5. Select "Custom" in the PlayerSpeech race dropdown.

For several custom voices, copy the folder under a new name (e.g. `PlayerSpeech_Pirate`), rename the `.toc` file to match the folder, and change `VOICE_NAME` in `Voice.lua`.
