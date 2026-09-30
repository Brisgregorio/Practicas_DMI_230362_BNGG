import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import assert from 'node:assert/strict';
import {pathToFileURL} from 'node:url';
const dir=path.resolve('architecture'),stem='yes-no-app-architecture',artifact=path.join(dir,stem+'.html');
const {ChromeVisualBrowser,findChrome,runVisualCheck,runBrowserCheck}=await import('file:///C:/Users/grego/.agents/skills/archify/bin/visual-check.mjs');
const hash=b=>crypto.createHash('sha256').update(b).digest('hex'),digest=hash(fs.readFileSync(artifact));
const options={artifactPath:artifact,verifyArtifact:()=>assert.equal(hash(fs.readFileSync(artifact)),digest),deliveryProvenance:{status:'custom-extension-hash-verified'}};
const browserGate=await runBrowserCheck(options);console.log('Final viewer browser gate:',browserGate.receipt.status);
const visual=await runVisualCheck(options);console.log('Final viewer visual capture:',visual.receipt.status);
const data=JSON.parse(fs.readFileSync(path.join(dir,stem+'.sources.json'))),browser=new ChromeVisualBrowser(findChrome());
const session=await browser.sessionPromise,send=(m,p={})=>browser.cdp.send(m,p,session);
const run=async expression=>{const r=await send('Runtime.evaluate',{expression,awaitPromise:true,returnByValue:true});if(r.exceptionDetails)throw Error(r.exceptionDetails.exception?.description);return r.result.value;};
const records=[];
try{
await send('Page.addScriptToEvaluateOnNewDocument',{source:'window.diagramErrors=[];addEventListener("error",e=>diagramErrors.push(e.message));addEventListener("unhandledrejection",e=>diagramErrors.push(String(e.reason)));'});
for(const theme of ['light','dark']){
await send('Emulation.setDeviceMetricsOverride',{width:1440,height:1000,deviceScaleFactor:1,mobile:false});
const loaded=browser.cdp.waitFor('Page.loadEventFired',session);await send('Page.navigate',{url:pathToFileURL(artifact).href+'?theme='+theme});await loaded;
await run('document.fonts.ready');
await run('new Promise(r=>requestAnimationFrame(()=>requestAnimationFrame(r)))');
assert.equal(await run('document.documentElement.dataset.theme'),theme);
for(const n of data.nodes){
await run(`architectureDetails.close();document.querySelector('.diagram-container [data-node-id="${n.id}"]').scrollIntoView({block:'center',behavior:'instant'});`);
await run('Archify.viewerChromeLayout.whenStable()'); await run('new Promise(r=>setTimeout(r,150))');
const point=await run(`(()=>{const r=document.querySelector('.diagram-container [data-node-id="${n.id}"]').getBoundingClientRect();return {x:r.x+r.width/2,y:r.y+r.height/2}})()`);
await run(`document.querySelector('.diagram-container [data-node-id="${n.id}"]').focus({preventScroll:true})`);
await send('Input.dispatchKeyEvent',{type:'keyDown',key:'Enter',code:'Enter',windowsVirtualKeyCode:13});await send('Input.dispatchKeyEvent',{type:'keyUp',key:'Enter',code:'Enter',windowsVirtualKeyCode:13});
await run('new Promise(r=>requestAnimationFrame(()=>requestAnimationFrame(r)))');
const result=await run(`(()=>{const c=document.getElementById('component-card');return {selected:Archify.focus.active(),id:c.dataset.component,visible:!c.hidden,text:c.textContent,links:[...c.querySelectorAll('a')].map(a=>({href:a.href,label:a.textContent,target:a.target}))}})()`);
assert.equal(result.id,n.id);assert.equal(result.visible,true);assert.equal(result.selected,n.id);assert.ok(result.text.includes(n.layer));assert.ok(result.text.includes(n.technology));
if(n.file){const link=result.links.find(l=>l.label==='Open source code');assert.ok(link);assert.equal(link.target,'_blank');assert.ok(link.href.includes('/blob/main/Practica_03/yes_no_app/'));}
records.push({theme,node:n.id,status:'pass',links:result.links});
if(n.id==='http'||n.id==='model'){const png=await send('Page.captureScreenshot',{format:'png',captureBeyondViewport:false});fs.writeFileSync(path.join(dir,stem+'.interaction-'+theme+'-'+n.id+'.png'),Buffer.from(png.data,'base64'));}
await send('Input.dispatchKeyEvent',{type:'keyDown',key:'Escape',code:'Escape',windowsVirtualKeyCode:27});await send('Input.dispatchKeyEvent',{type:'keyUp',key:'Escape',code:'Escape',windowsVirtualKeyCode:27});assert.equal(await run('document.getElementById("component-card").hidden'),true);
}
const resetLoaded=browser.cdp.waitFor('Page.loadEventFired',session);await send('Page.navigate',{url:pathToFileURL(artifact).href+'?theme='+theme+'&capture=overview'});await resetLoaded;await run('document.fonts.ready');await run('Archify.viewerChromeLayout.whenStable()');await run('new Promise(r=>setTimeout(r,250))');
const metrics=await send('Page.getLayoutMetrics');const png=await send('Page.captureScreenshot',{format:'png',captureBeyondViewport:true,clip:{x:0,y:0,width:1440,height:Math.ceil(metrics.cssContentSize.height),scale:1}});fs.writeFileSync(path.join(dir,stem+'.full-'+theme+'.png'),Buffer.from(png.data,'base64'));
assert.deepEqual(await run('diagramErrors'),[]);
}
}finally{await browser.close();}
fs.writeFileSync(path.join(dir,stem+'.interaction-check.json'),JSON.stringify({status:'pass',artifactSha256:digest,checks:records,escapeCloses:true,runtimeErrors:[],sourceLinks:'All internal node cards expose main source links in new tabs; remote navigation not fetched.'},null,2));
const sourceCheck=JSON.parse(fs.readFileSync(path.join(dir,stem+'.source-check.json')));
for(const s of data.sources)assert.equal(hash(fs.readFileSync(s.path.replace('Practica_03/yes_no_app/',''))),s.sha256);
const receipt={status:browserGate.exitCode===0&&visual.exitCode===0?'pass':'fail',diagramType:'architecture',artifact:{path:stem+'.html',sha256:digest,bytes:fs.statSync(artifact).size},specification:{path:stem+'.json',sha256:hash(fs.readFileSync(path.join(dir,stem+'.json')))},nativeArchifyReceipt:'encoding-review/'+stem+'.finalize.json',provenance:'Final viewer extends the preserved native Archify HTML with layer navigation, detailed cards and main source URLs. Native receipts bind only archify/ HTML. Final viewer checks and this custom receipt bind the extended HTML.',jsonValidation:'Archify showcase passed',sourceValidation:sourceCheck.status,browserEvidence:browserGate.receipt.status,visualCapture:visual.receipt.status,visualReview:'pending',interactionCheck:'pass',nodeInteractions:records.length,applicationSourceUnmodified:true,limitations:data.limitations};
fs.writeFileSync(path.join(dir,stem+'.delivery.json'),JSON.stringify(receipt,null,2));
console.log(JSON.stringify(receipt));

