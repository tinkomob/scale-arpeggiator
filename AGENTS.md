# Max for Live MIDI Generators

## Scope and files

- These are Ableton Live 12 MIDI Tools used in the clip editor's Generate tab. Build a MIDI Generator, not a real-time MIDI effect.
- `Scale Arpeggiator.amxd` is the installed device; `scale_arp.js` is its required companion script. Keep them together.
- Keep `Scale Arpeggiator.maxpat` consistent with the patch embedded in the `.amxd` when editing patch structure.
- Preserve unrelated devices in this directory.
- If writing Go code, do not create build or test cache folders inside the project directory.

## Product requirements

- Follow the active Live root and scale through the MIDI Tool context. Support the supplied scale intervals, including custom scales; do not hard-code major/minor or add manual root/scale overrides.
- Fill the selected time range. Without a time selection, fill the clip's active loop range. Confirm Live's actual context values before changing this fallback behavior.
- Use beat units for start times and durations. Respect nonzero selection starts and clip every note's end to the target range.
- Generate musical, repeating arpeggio motifs with controlled randomness.
- Generate rolls a new phrase. Parameter edits preserve the phrase's random seed.
- Length changes durations only, preserving pitches, velocities, note positions, and count.
- Variation changes existing generated pitches and velocities, preserving note positions and count.
- Every control must request an update after storing its new value. Verify Auto-on and Auto-off behavior in Live; do not assume that a patch connection alone implements the Auto toggle correctly.

## Fixed viewport and controls

- The usable MIDI Tool viewport is **152 × 147 pixels**. Keep all presentation rectangles entirely inside it; do not rely on scrolling or a wider window.
- Set `devicewidth` to `152`, `openrect` to `[0, 0, 152, 147]`, and `openinpresentation` to `1`.
- Every visible object needs `presentation: 1` and an explicit `presentation_rect`. Keep internal logic out of presentation.
- No title, description, or footer: spend the viewport on controls.
- Step must be a `live.dial` with readable rhythmic values, not a dropdown.
- Use a compact two-column layout, short labels, consistent spacing, and legible contrast. Check text clipping inside Live.
- Serialize UI objects with their actual `maxclass` (`live.dial`, `live.menu`, `live.numbox`), not as `newobj` boxes containing those names.
- Configure Live parameter metadata under `saved_attribute_attributes.valueof`: names, types, ranges, defaults, and `parameter_enum` for menus or enumerated dials. Setting `items` alone previously left the menu displaying default labels such as "two".

## Approved Chord Generator field alignment

- The user approved the current vertical alignment of `Chord Generator.maxpat` on 2026-11-11. Preserve it when editing the UI.
- Visible `live.menu` and `live.numbox` fields start **1 pixel below** their adjacent comment labels: top Start/Size labels at y=2, fields at y=3; Strum/Motion labels at y=97, fields at y=98; Velo/Prob labels at y=114, fields at y=115; Length/Voice labels at y=131, fields at y=132.
- Keep field bottoms unchanged: top selectors have height 14, lower fields height 13. Match their `patching_rect` dimensions to their `presentation_rect` dimensions.
- This +1 px offset is intentional: zero offset looked too high, +2 px looked too low. Do not apply this offset to dials, dial captions, or dial readouts.

## MIDI Tool architecture and encountered failures

- Use `C:\ProgramData\Ableton\Live 12 Suite\Resources\Max\resources\help` as the primary local reference for Max objects. Consult the installed object help patches for supported attributes, messages, UI styling, and wiring examples before implementing or changing an object; use online documentation when the local help does not cover the needed detail.
- Start with the installed native template: `C:/ProgramData/Ableton/Live 12 Suite/Resources/Misc/Max MIDI Tools/Max MIDI Generator.amxd`. Preserve its container metadata instead of inventing a device wrapper.
- The original `metro` / `makenote` / `noteout` patch did not implement the clip-generation protocol and caused: "Did not receive a Note dictionary in time. Make sure that the dictionary is synchronous."
- Use `live.miditool.in` and `live.miditool.out`. Each generation request must return a note dictionary synchronously in the same event chain. Do not use timers, deferred tasks, Node processes, or asynchronous callbacks in that chain.
- Context comes from `live.miditool.in` outlet 1; note data comes from outlet 0. Store current context before generating. Verify ordering if changing these connections.
- Do not connect an incoming dictionary to a script that only handles `bang`. Convert it with `t b` or implement the dictionary handler explicitly. This missing conversion previously prevented output.
- The current legacy `js` script has two inlets: context dictionaries on inlet 1 and generation/settings messages on inlet 0. It emits `dictionary <name>` from outlet 0 using a persistent Max `Dict`.
- Output schema: `{ "notes": [{ "pitch": 60, "start_time": 0, "duration": 0.25, "velocity": 100 }] }`. Pitch, start time, and duration are required; validate MIDI pitch bounds and positive duration.
- All six parameter-message paths currently share `t b l`: its right outlet sends the setting to the script first, then its left outlet bangs `live.miditool.in`. Previously controls only stored settings, so changing parameters did not update MIDI.
- Request fresh context through `live.miditool.in`; do not emit notes directly from a parameter setter outside a Live generation transaction.
- Keep random generation repeatable for parameter edits. Previously rerolling on each edit changed the phrase when only Length was adjusted.
- When editing `.amxd` containers, derive the header from the native template and update the patch chunk byte length correctly. Preserve its terminator convention. Valid JSON by itself does not prove a valid or functioning Live device.

## Verification and delivery

- Run `node check-scale-arp.cjs` for the existing scale/range checks when changing generation logic.
- Add focused checks for affected behavior: custom scales, nonzero selection starts, whole-loop fallback, partial final steps, MIDI pitch bounds, and preservation of notes on Length/Variation edits.
- A mocked JavaScript test does not verify Max object creation, script loading, parameter initialization, Auto behavior, synchronous Live transactions, or viewport fit.
- Before claiming the device works, verify inside Live: reload it, inspect all controls, generate into a disposable clip, change each parameter with Auto on, test Auto off, test a time selection and no selection, and change Live's root/scale.
- Reload by selecting another generator and returning. Ensure the companion script is present and inspect the Max console for script or object errors if generation fails.
- Do not alter the user's existing musical clips for verification without authorization; use a disposable clip.
- Report exactly what was checked. Earlier revisions repeatedly shipped without Live verification; do not describe a logic check as an end-to-end success. As of this document's creation, the latest Auto/Variation/Length fixes and layout still require verification inside Live.
