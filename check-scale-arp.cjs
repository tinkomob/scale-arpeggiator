const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const scope = {Dict:function(){}, outlet(){}, Math, JSON};
vm.createContext(scope);
vm.runInContext(fs.readFileSync('scale_arp.js','utf8'),scope);
for (let pattern=0;pattern<4;pattern++) {
 const settings={rate:1,pattern,octaves:3,variation:70,register:4,gate:90};
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
console.log('Passed: four motions, custom scale, offset selection, end clipping, full loop fallback.');
