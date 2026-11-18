autowatch = 1;
inlets = 2;
outlets = 3;
var context = {};
var settings = {rate:0, pattern:0, octaves:2, register:4, gate:75, breath:0, firstnote:0};
var result = new Dict();
var parameterChange = false;
var phraseSeed = 1;
function dictionary(name) {
    if (inlet === 1) context = JSON.parse(new Dict(name).stringify());
    else bang();
}
function rate(v) { parameterChange = true; settings.rate = Math.max(0,Math.min(4,Math.round(v))); }
function setBreathVisible(visible) { var hidden=visible?0:1; outlet(2,'script','sendbox','breath','hidden',hidden); outlet(2,'script','sendbox','breathlabel','hidden',hidden); }
function loadbang() { setBreathVisible(false); }
function pattern(v) { parameterChange = true; settings.pattern = Math.max(0,Math.min(8,Math.round(v))); setBreathVisible(settings.pattern===8); }
function breath(v) { parameterChange = true; settings.breath = Math.max(0,Math.min(100,Math.round(v))); }
function firstnote(v) { parameterChange = true; settings.firstnote = Math.max(0,Math.min(8,Math.round(v))); }
function octaves(v) { parameterChange = true; settings.octaves = Math.max(1,Math.min(4,Math.round(v))); }
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
    var firstMode=Math.round(Number(s.firstnote)||0), firstIndex=firstMode===1 ? Math.floor(random()*pool.length) : Math.min(pool.length-1,Math.max(0,firstMode-1));
    var step = s.rate===0 ? Number((c.grid||{}).interval)||0.25 : [0.5,0.25,0.125,1/3][s.rate-1];
    var count = Math.ceil((end-start)/step-0.0000001), notes=[], phrase=[], cursor=0;
    var variation=0.35;
    if(s.pattern===8) {
        var totalSlots=Math.floor((end-start)/step+0.0000001);
        var gapSlots=Math.round(totalSlots*0.5*s.breath/100);
        var phraseSlots=totalSlots-gapSlots;
        if(phraseSlots<2) return [];
        var questionSlots=Math.max(1,Math.min(phraseSlots-1,Math.round(phraseSlots*(0.35+random()*0.3))));
        var answerSlots=phraseSlots-questionSlots;
        var style=Math.floor(random()*3), questionComplex=style===0 || style===2, answerComplex=style===1 || style===2;
        function eventCount(slots, complex) {
            return Math.min(slots,complex?Math.min(8,Math.max(3,Math.round(slots*0.9))):Math.min(4,Math.max(2,Math.round(slots*0.75))));
        }
        var questionCount=eventCount(questionSlots,questionComplex), answerCount=eventCount(answerSlots,answerComplex);
        var questionCurve=questionComplex?[0,0.32,0.2,0.58,0.42,0.78,1,0.86]:[0,0.4,0.72,0.9];
        var answerCurve=answerComplex?[0.82,0.55,0.72,0.36,0.52,0.18,0.3,0]:[0.82,0.58,0.32,0];
        for(i=0;i<questionCount+answerCount;i++) {
            var answer=i>=questionCount, j=answer?i-questionCount:i;
            var n=answer?answerCount:questionCount, slots=answer?answerSlots:questionSlots;
            var curve=answer?answerCurve:questionCurve;
            var curveIndex=Math.round(j*(curve.length-1)/Math.max(1,n-1));
            var ix=firstIndex+Math.round(curve[curveIndex]*(pool.length-1-firstIndex));
            if(j>0 && random()<variation && pool.length>2) ix+=random()<0.5?-1:1;
            ix=Math.max(0,Math.min(pool.length-1,ix));
            if(notes.length && pool.length>1 && pool[ix]===notes[notes.length-1].pitch) {
                var prevIndex=pool.indexOf(notes[notes.length-1].pitch);
                ix=Math.max(0,Math.min(pool.length-1,prevIndex+(answer?-1:1)));
            }
            var slot=Math.round(j*(slots-1)/Math.max(1,n-1))+(answer?questionSlots+gapSlots:0);
            var time=start+slot*step;
            if(time>=end) continue;
            var velocity=Math.round((j===0?108:88)+(random()-0.5)*24*variation);
            notes.push({pitch:pool[ix],start_time:time,duration:Math.min(step*s.gate/100,end-time),velocity:velocity});
        }
        return notes;
    }
    // A repeated eight-step motif keeps the random choices recognisable as a phrase.
    for(i=0;i<8;i++) {
        var ix;
        if(s.pattern===0) ix=(i*2)%pool.length;
        else if(s.pattern===1) ix=pool.length-1-(i*2)%pool.length;
        else if(s.pattern===2) { var period=Math.max(1,2*(pool.length-1)); var phase=(i*2)%period; ix=phase<pool.length?phase:period-phase; }
        else if(s.pattern===3) { cursor=Math.max(0,Math.min(pool.length-1,cursor+([-2,-1,1,2][Math.floor(random()*4)]))); ix=cursor; }
        else if(s.pattern===4) ix=i%pool.length;
        else if(s.pattern===5) ix=pool.length-1-(i%pool.length);
        else if(s.pattern===6) ix=i%2===0?Math.floor(i/2)%pool.length:pool.length-1-Math.floor(i/2)%pool.length;
        else if(s.pattern===7) ix=Math.floor(random()*pool.length);
        else ix=Math.round([0,1/3,2/3,1,3/4,1/2,1/4,0][i]*(pool.length-1));
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
    if(notes.length) notes[0].pitch=pool[firstIndex];
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
