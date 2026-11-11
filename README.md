# Scale Arpeggiator

Max for Live MIDI Generator for Ableton Live 12's clip editor Generate tab. Requires Max for Live.

## Install

Copy `Scale Arpeggiator.amxd` and `scale_arp.js` together into Ableton User Library/MIDI Tools/Max Generators. Select it in Generate. Switch to another generator and back to reload updates.

Uses Live's root and supplied scale intervals, including custom scales. Fills the selected beat range or active loop. Controls: Step, Motion, Octaves, Base octave, Variation, and Length. Generate rolls a new phrase; parameter edits retain the random seed. Length preserves pitches, velocities, positions, and count.

## Development and checks

`Scale Arpeggiator.maxpat` is the source patch and must match the patch embedded in `.amxd`. Preserve the native device container header and correct patch byte length.

Run `node check-scale-arp.cjs` from this directory. Read AGENTS.md for protocol and UI constraints. The logic tests cover four motions, custom scales, nonzero range starts, clipping and loop fallback; they do not establish end-to-end Live behavior. Verify loading, all controls, Auto on/off, and scale changes in Live on a disposable clip.

No project-wide license has been assigned.
