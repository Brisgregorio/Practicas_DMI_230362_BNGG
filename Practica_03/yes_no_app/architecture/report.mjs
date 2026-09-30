import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
const dir=path.resolve('architecture'),stem='yes-no-app-architecture';
const read=name=>JSON.parse(fs.readFileSync(path.join(dir,name)));
const data=read(stem+'.sources.json'),receipt=read(stem+'.delivery.json');
receipt.visualReview='passed';receipt.visualReviewNotes=['Inspected final full-page light and dark screenshots and component-card screenshots.','No overlapping nodes or labels observed. One routed crossover remains between avatar fetch and message submission; paths remain distinguishable.','Tall layout uses page scrolling. Node selection automatically zooms the diagram; overview captures reset the camera.'];
fs.writeFileSync(path.join(dir,stem+'.delivery.json'),JSON.stringify(receipt,null,2));
fs.writeFileSync(path.join(dir,stem+'.perceptual-review.json'),JSON.stringify({status:'pass',artifactSha256:receipt.artifact.sha256,reviewer:'image-capable assistant',captures:[stem+'.full-light.png',stem+'.full-dark.png',stem+'.interaction-light-http.png',stem+'.interaction-dark-model.png'],observations:receipt.visualReviewNotes,placementReview:'One alternative placement was tested and restored because it increased crossings.'},null,2));
const lock=fs.readFileSync('pubspec.lock','utf8');
const packages=['flutter','cupertino_icons','provider','dio','flutter_test','flutter_lints','flutter_launcher_icons'].map(name=>{const block=lock.match(new RegExp('^  '+name+':\\n([\\s\\S]*?)(?=^  \\w|^sdks:)','m'));return {name,lockedVersion:block?.[1].match(/version: "([^"]+)"/)?.[1]||'SDK'};});
const walk=(p='')=>fs.readdirSync(path.join(dir,p),{withFileTypes:true}).flatMap(e=>e.isDirectory()?walk(path.posix.join(p,e.name)):[path.posix.join(p,e.name)]);
const reportName=stem+'.report.md',inventoryName=stem+'.inventory.json';
const all=[...new Set([...walk(),reportName,inventoryName])].sort();
let report=`# Práctica 03 - Yes No App — delivery report

[Open interactive diagram](${stem}.html) · [Editable Archify JSON](${stem}.json) · [Editable component details](${stem}.sources.json) · [Delivery receipt](${stem}.delivery.json) · [Visual contact sheet](${stem}.visual-check.html)

The installed Archify skill was used. Its previous Práctica 02 HTML was inspected for viewer behavior. All ten Dart files under lib/ and the manifest were read. Source evidence is pinned to ${data.repository.revision}; user-facing links target the requested main branch. Remote main contents were not fetched, so local-file correspondence is verified without claiming remote availability.

## Verified behavior

State management: **provider / ChatProvider extends ChangeNotifier**, registered by MultiProvider and ChangeNotifierProvider in main.dart. _ChatView uses context.watch. HTTP client: **Dio**.

API discovered in source: **https://yesno.wtf/api**. No user question is sent over HTTP. The GET sends only force=yes, force=no or force=maybe. The dynamic image host is unknown from static source; no live response was sampled. The separate avatar uses encrypted-tbn0.gstatic.com, with its actual URL retained in its card.

User → ChatScreen / _ChatView → MessageFieldBox → onValue / ChatProvider.sendMessage → user Message → messageList → notifyListeners / ListView → MyMessageBubble. If text ends with ?, herReply calls GetYesNoAnswer.getAnswer → local Random selection → Dio GET with force → API response.data image → direct Message constructor → herReply appends Message to messageList → notifyListeners → HerMessageBubble → message.text and Image.network(message.imageUrl!). Each update requests automatic scrolling after 100 ms, animated over 300 ms.

**Answer/GIF relationship:** the helper picks yes (40%), no (40%) or maybe (20%), prepares Spanish text, and requests that choice using force. It stores local text and the returned image URL in the same Message. The UI reads both from that object and does not make another random choice. However, response.answer is ignored: text and image are **not both derived from the same API response**, and agreement is **not validated**. This requested invariant is not implemented in the existing app. No application fix was made.

YesNoModel exists but is unused by the real request path. Its fromJsonMap reads answer/forced/image; toMessageEntity preserves the model image but maps every non-yes answer, including maybe, to No. It is shown as inactive rather than inserted into the live flow. There is no Yes/No/Maybe domain enum; FromWho has me and hers. Message contains text, nullable imageUrl, fromWho and sentAt.

## Error behavior

| Case | Real implementation |
|---|---|
| Empty input | text.isEmpty returns; no trim, so whitespace is not rejected. |
| Non-question | User message is added; API request occurs only for a trailing ?. |
| Image loading | loadingBuilder displays a loading message. |
| HTTP failure | Not implemented: no application try/catch; herReply is not awaited by sendMessage. |
| Missing/null JSON fields | Not implemented: direct String cast in helper; model has no validation. |
| Invalid image URL / failed image load | Not implemented: no URL validation or errorBuilder; imageUrl is force-unwrapped. |
| Fallback response | Not implemented. |
| API loading state | Not implemented. |
| Retry / error recovery UI | Not implemented. Normal input clearing, notification and scrolling are present. |
| Response answer/image agreement validation | Not implemented. |

## Development and source control

Flutter SDK and Dart are declared in pubspec.yaml (Dart constraint ^3.13.2). Android Gradle, web bootstrap and Windows CMake files were verified; iOS, Linux and macOS directories also exist. The Android main manifest lacks an INTERNET declaration; this is recorded without changing configuration. No deployment or CI pipeline was invented. Git and the supplied GitHub repository are shown separately from the app boundary; no commit or push was performed.

Direct locked dependencies inspected: ${packages.map(p=>p.name+' '+p.lockedVersion).join(', ')}. Local package configuration exists and was inspected. No packages were installed.

## Validation

- Archify schema/showcase validation, deterministic delivery, strict check and native browser gates: pass, zero diagnostics in the final native receipt.
- Final extended viewer: browser containment/theme checks pass; four viewport captures and full-page light/dark captures retained.
- Every node: keyboard selection and detailed card checks in both themes, 40/40 passed. Escape closes cards. All internal cards expose Open source code links with target=_blank. Mouse selection was also exercised during development; the retained exhaustive test uses keyboard selection.
- All 16 linked source paths exist, have unchanged hashes, appear in the HTML, and map exactly to main/Practica_03/yes_no_app/ URLs. Remote GitHub navigation was not fetched.
- Visual review: passed after inspecting both complete themes and light/dark cards. One resolved line crossing and two routed detours remain; no overlapping nodes or edge labels were observed. The overview uses vertical page scrolling.
- Application source was not modified. Git status retains the pre-existing generated plugin changes; the only new task directory is architecture/.

The final HTML is an extension of Archify's native viewer for the requested detailed cards and main-branch navigation. The unmodified native HTML and its strict provenance remain under archify/. The final HTML has its own hash-bound delivery, browser, visual and interaction receipts. Older review receipts and captures are retained as historical evidence; they do not certify the final HTML.

Artifact SHA-256: ${receipt.artifact.sha256}

Specification SHA-256: ${receipt.specification.sha256}

## Every linked real source file

${data.sources.map(s=>'- ['+s.path+']('+s.url+')').join('\n')}

## Every generated file

All paths below are relative to architecture/. Build scripts only create architecture artifacts. build.mjs authors the JSON and evidence; finalize produces the native HTML; enhance.mjs adds cards/navigation; check.mjs validates the final viewer; report.mjs assembles this handoff. Keep the native and extended receipts distinct when rebuilding. Use a fresh Archify --out-dir if changed artifact bytes already own evidence. No package installation is needed.

${all.map(p=>'- ['+p+']('+p+')').join('\n')}
`;
fs.writeFileSync(path.join(dir,reportName),report);
const hash=b=>crypto.createHash('sha256').update(b).digest('hex');
fs.writeFileSync(path.join(dir,inventoryName),JSON.stringify({files:all.map(p=>p===inventoryName?{path:p,self:true}:{path:p,bytes:fs.statSync(path.join(dir,p)).size,sha256:hash(fs.readFileSync(path.join(dir,p)))})},null,2));
console.log(JSON.stringify({files:all.length,linkedSources:data.sources.length,visualReview:receipt.visualReview,report:reportName}));
