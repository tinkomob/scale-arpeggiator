const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const scope = {Dict:function(){}, outlet(){}, Math, JSON};
vm.createContext(scope);
vm.runInContext(fs.readFileSync('scale_arp.js','utf8'),scope);
for (let pattern=0;pattern<8;pattern++) {
 const settings={rate:2,pattern,octaves:3,register:4,gate:90};
 const context={clip:{time_selection_start:3.125,time_selection_end:11.3},scale:{root_note:2,scale_intervals:[0,2,3,7,9]}};
 const notes=scope.generate(context,settings,Math.random);
 assert.equal(notes.length,33);
 for(const note of notes){
  assert([2,4,5,9,11].includes(note.pitch%12));
  assert(note.start_time>=3.125 && note.start_time<11.3);
  assert(note.duration>0 && note.start_time+note.duration<=11.3+1e-9);
 }
 const entire=scope.generate({clip:{time_selection_start:0,time_selection_end:0,loop_start:8,loop_end:40},scale:context.scale},settings,Math.random);
 assert.equal(entire.length,128);
 assert.equal(entire[0].start_time,8);
 assert(entire[127].start_time+entire[127].duration<=40);
}
const qa=scope.generate({clip:{time_selection_start:0,time_selection_end:2},scale:{root_note:0,scale_intervals:[0,2,4,5,7,9,11]}},{rate:2,pattern:8,octaves:2,register:4,gate:100,breath:0},()=>0.5);
assert.equal(qa.length,7);
assert.equal(qa[3].start_time-qa[2].start_time,0.25);
for(let i=1;i<qa.length;i++) assert.notEqual(qa[i].pitch,qa[i-1].pitch);
const qaMax=scope.generate({clip:{time_selection_start:0,time_selection_end:4},scale:{root_note:0,scale_intervals:[0,2,4,5,7,9,11]}},{rate:2,pattern:8,octaves:2,register:4,gate:100,breath:100},()=>0.5);
assert.equal(qaMax.length,7);
assert(qaMax[3].start_time-qaMax[2].start_time>0.25);
assert.equal(qaMax[6].start_time+qaMax[6].duration,4);
const qaLong=scope.generate({clip:{time_selection_start:0,time_selection_end:8},scale:{root_note:0,scale_intervals:[0,2,4,5,7,9,11]}},{rate:2,pattern:8,octaves:2,register:4,gate:100,breath:100},()=>0.5);
assert(qaLong.length>8);
assert.equal(qaLong[qaLong.length-1].start_time+qaLong[qaLong.length-1].duration,8);
const firstContext={clip:{time_selection_start:0,time_selection_end:2},scale:{root_note:2,scale_intervals:[0,2,3,7,9]}};
const firstSettings={rate:2,pattern:0,octaves:3,register:4,gate:100};
assert.equal(scope.generate(firstContext,{...firstSettings,firstnote:0},()=>0.5)[0].pitch,50);
assert.equal(scope.generate(firstContext,{...firstSettings,firstnote:2},()=>0.5)[0].pitch,52);
const firstRandom=scope.generate(firstContext,{...firstSettings,firstnote:1},()=>0.5)[0].pitch;
assert([50,52,53,57,59,62,64,65,69,71,74,76,77,81,83].includes(firstRandom));
const gridNotes=scope.generate({clip:{time_selection_start:2,time_selection_end:3},grid:{interval:0.125},scale:{root_note:0,scale_intervals:[0]}},{rate:0,pattern:0,octaves:1,register:5,gate:100},()=>0.5);
assert.equal(gridNotes.length,8);
assert.equal(gridNotes[1].start_time-gridNotes[0].start_time,0.125);
console.log('Passed: four motions, custom scale, offset selection, end clipping, full loop fallback.');
