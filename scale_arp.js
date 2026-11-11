autowatch = 1;
inlets = 2;
outlets = 2;
var context = {};
var settings = {rate:1, pattern:0, octaves:2, variation:35, register:4, gate:75};
var result = new Dict();
var parameterChange = false;
var phraseSeed = 1;
function dictionary(name) {
    if (inlet === 1) context = JSON.parse(new Dict(name).stringify());
    else bang();
}
function rate(v) { parameterChange = true; settings.rate = Math.max(0,Math.min(3,Math.round(v))); }
function pattern(v) { parameterChange = true; settings.pattern = Math.max(0,Math.min(3,Math.round(v))); }
function octaves(v) { parameterChange = true; settings.octaves = Math.max(1,Math.min(4,Math.round(v))); }
function variation(v) { parameterChange = true; settings.variation = Math.max(0,Math.min(100,v)); }
function register(v) { parameterChange = true; settings.register = Math.max(0,Math.min(8,Math.round(v))); }
function gate(v) { parameterChange = true; settings.gate = Math.max(10,Math.min(100,v)); }
function generate(c, s, random) {
    var clip = c.clip || {}, scale = c.scale || {};
    var start = Number(clip.time_selection_start), end = Number(clip.time_selection_end);
    if (!isFinite(start) || !isFinite(end) || end <= start) {
        start = Number(clip.loop_start); end = Number(clip.loop_end);
    }
    if (!isFinite(start) || !isFinite(end) || end <= start) return [];
    var root = Number(scale.root_note) || 0;
    var intervals = scale.scale_intervals;
    if (!intervals || !intervals.length) return [];
    var pool = [], i, o;
    for(o=0;o<s.octaves;o++) for(i=0;i<intervals.length;i++) {
        var pitch = s.register*12 + root + Number(intervals[i]) + 12*o;
        if(pitch>=0 && pitch<=127 && pool.indexOf(pitch)<0) pool.push(pitch);
    }
    pool.sort(function(a,b){return a-b;});
    if (!pool.length) return [];
    var step = [0.5,0.25,0.125,1/3][s.rate];
    var count = Math.ceil((end-start)/step-0.0000001), notes=[], phrase=[], cursor=0;
    var variation=s.variation/100;
    // A repeated eight-step motif keeps the random choices recognisable as a phrase.
    for(i=0;i<8;i++) {
        var ix;
        if(s.pattern===0) ix=(i*2)%pool.length;
        else if(s.pattern===1) ix=pool.length-1-(i*2)%pool.length;
        else if(s.pattern===2) { var period=Math.max(1,2*(pool.length-1)); var phase=(i*2)%period; ix=phase<pool.length?phase:period-phase; }
        else { cursor=Math.max(0,Math.min(pool.length-1,cursor+([-2,-1,1,2][Math.floor(random()*4)]))); ix=cursor; }
        if(random()<variation) ix=Math.floor(random()*pool.length);
        phrase.push(ix);
    }
    for(i=0;i<count;i++) {
        var time=start+i*step;
        if(time>=end) break;
        var index=phrase[i%8];
        if(i>=8 && i%8>=6 && random()<variation) index=Math.floor(random()*pool.length);
        var velocity=Math.round((i%4===0?108:88)+(random()-0.5)*24*variation);
        notes.push({pitch:pool[index], start_time:time, duration:Math.min(step*s.gate/100,end-time), velocity:velocity});
    }
    return notes;
}
function bang() {
    // Live supplies loop bounds as the time range when there is no time selection.
    if (!parameterChange) phraseSeed = Math.floor(Math.random()*2147483646)+1;
    parameterChange = false;
    var state = phraseSeed;
    function phraseRandom() { state = state * 16807 % 2147483647; return (state-1)/2147483646; }
    var notes=generate(context,settings,phraseRandom);
    result.parse(JSON.stringify({notes:notes}));
    outlet(0,'dictionary',result.name);
    var scale=context.scale || {};
    var names=['C','C#','D','Eb','E','F','F#','G','Ab','A','Bb','B'];
    outlet(1,'set',names[Number(scale.root_note)||0]+' '+(scale.scale_name||'Live scale')+' / '+notes.length+' notes');
}
