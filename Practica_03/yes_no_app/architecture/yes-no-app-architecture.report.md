# Práctica 03 - Yes No App — delivery report

[Open interactive diagram](yes-no-app-architecture.html) · [Editable Archify JSON](yes-no-app-architecture.json) · [Editable component details](yes-no-app-architecture.sources.json) · [Delivery receipt](yes-no-app-architecture.delivery.json) · [Visual contact sheet](yes-no-app-architecture.visual-check.html)

The installed Archify skill was used. Its previous Práctica 02 HTML was inspected for viewer behavior. All ten Dart files under lib/ and the manifest were read. Source evidence is pinned to 007b7595ca0879ed28dd4e40b8d8f08deafb67b2; user-facing links target the requested main branch. Remote main contents were not fetched, so local-file correspondence is verified without claiming remote availability.

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

Direct locked dependencies inspected: flutter SDK, cupertino_icons SDK, provider SDK, dio SDK, flutter_test SDK, flutter_lints SDK, flutter_launcher_icons SDK. Local package configuration exists and was inspected. No packages were installed.

## Validation

- Archify schema/showcase validation, deterministic delivery, strict check and native browser gates: pass, zero diagnostics in the final native receipt.
- Final extended viewer: browser containment/theme checks pass; four viewport captures and full-page light/dark captures retained.
- Every node: keyboard selection and detailed card checks in both themes, 40/40 passed. Escape closes cards. All internal cards expose Open source code links with target=_blank. Mouse selection was also exercised during development; the retained exhaustive test uses keyboard selection.
- All 16 linked source paths exist, have unchanged hashes, appear in the HTML, and map exactly to main/Practica_03/yes_no_app/ URLs. Remote GitHub navigation was not fetched.
- Visual review: passed after inspecting both complete themes and light/dark cards. One resolved line crossing and two routed detours remain; no overlapping nodes or edge labels were observed. The overview uses vertical page scrolling.
- Application source was not modified. Git status retains the pre-existing generated plugin changes; the only new task directory is architecture/.

The final HTML is an extension of Archify's native viewer for the requested detailed cards and main-branch navigation. The unmodified native HTML and its strict provenance remain under archify/. The final HTML has its own hash-bound delivery, browser, visual and interaction receipts. Older review receipts and captures are retained as historical evidence; they do not certify the final HTML.

Artifact SHA-256: 321207209986e09a1e3368ab214ea84dd64333bec4209de9408da2ebb9964e69

Specification SHA-256: d7272d59694c05f1b962739335bff3e59cfe01a8f17d2e34136454c02039d086

## Every linked real source file

- [Practica_03/yes_no_app/lib/main.dart](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/lib/main.dart)
- [Practica_03/yes_no_app/lib/config/theme/app_theme.dart](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/lib/config/theme/app_theme.dart)
- [Practica_03/yes_no_app/lib/config/helpers/get_yes_no_answer.dart](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/lib/config/helpers/get_yes_no_answer.dart)
- [Practica_03/yes_no_app/lib/domain/entities/message.dart](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/lib/domain/entities/message.dart)
- [Practica_03/yes_no_app/lib/infrastructure/models/yes_no_model.dart](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/lib/infrastructure/models/yes_no_model.dart)
- [Practica_03/yes_no_app/lib/presentation/providers/chat_provider.dart](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/lib/presentation/providers/chat_provider.dart)
- [Practica_03/yes_no_app/lib/presentation/screens/chat/chat_screen.dart](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/lib/presentation/screens/chat/chat_screen.dart)
- [Practica_03/yes_no_app/lib/presentation/widgets/shared/message_field_box.dart](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/lib/presentation/widgets/shared/message_field_box.dart)
- [Practica_03/yes_no_app/lib/presentation/widgets/chat/my_message_bubble.dart](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/lib/presentation/widgets/chat/my_message_bubble.dart)
- [Practica_03/yes_no_app/lib/presentation/widgets/chat/her_message_bubble.dart](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/lib/presentation/widgets/chat/her_message_bubble.dart)
- [Practica_03/yes_no_app/pubspec.yaml](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/pubspec.yaml)
- [Practica_03/yes_no_app/pubspec.lock](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/pubspec.lock)
- [Practica_03/yes_no_app/android/app/build.gradle.kts](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/android/app/build.gradle.kts)
- [Practica_03/yes_no_app/android/app/src/main/AndroidManifest.xml](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/android/app/src/main/AndroidManifest.xml)
- [Practica_03/yes_no_app/web/index.html](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/web/index.html)
- [Practica_03/yes_no_app/windows/CMakeLists.txt](https://github.com/Brisgregorio/Practicas_DMI_230362/blob/main/Practica_03/yes_no_app/windows/CMakeLists.txt)

## Every generated file

All paths below are relative to architecture/. Build scripts only create architecture artifacts. build.mjs authors the JSON and evidence; finalize produces the native HTML; enhance.mjs adds cards/navigation; check.mjs validates the final viewer; report.mjs assembles this handoff. Keep the native and extended receipts distinct when rebuilding. Use a fresh Archify --out-dir if changed artifact bytes already own evidence. No package installation is needed.

- [archify/yes-no-app-architecture.browser-check.json](archify/yes-no-app-architecture.browser-check.json)
- [archify/yes-no-app-architecture.delivery.json](archify/yes-no-app-architecture.delivery.json)
- [archify/yes-no-app-architecture.finalize-summary.json](archify/yes-no-app-architecture.finalize-summary.json)
- [archify/yes-no-app-architecture.finalize.json](archify/yes-no-app-architecture.finalize.json)
- [archify/yes-no-app-architecture.html](archify/yes-no-app-architecture.html)
- [archive-evidence.mjs](archive-evidence.mjs)
- [before-placement-review.json](before-placement-review.json)
- [build.mjs](build.mjs)
- [check.mjs](check.mjs)
- [earlier-viewer-check/yes-no-app-architecture.browser-check.json](earlier-viewer-check/yes-no-app-architecture.browser-check.json)
- [earlier-viewer-check/yes-no-app-architecture.visual-check.1440x900.dark.png](earlier-viewer-check/yes-no-app-architecture.visual-check.1440x900.dark.png)
- [earlier-viewer-check/yes-no-app-architecture.visual-check.1440x900.light.png](earlier-viewer-check/yes-no-app-architecture.visual-check.1440x900.light.png)
- [earlier-viewer-check/yes-no-app-architecture.visual-check.2048x1320.dark.png](earlier-viewer-check/yes-no-app-architecture.visual-check.2048x1320.dark.png)
- [earlier-viewer-check/yes-no-app-architecture.visual-check.2048x1320.light.png](earlier-viewer-check/yes-no-app-architecture.visual-check.2048x1320.light.png)
- [earlier-viewer-check/yes-no-app-architecture.visual-check.html](earlier-viewer-check/yes-no-app-architecture.visual-check.html)
- [earlier-viewer-check/yes-no-app-architecture.visual-check.json](earlier-viewer-check/yes-no-app-architecture.visual-check.json)
- [encoding-review/yes-no-app-architecture.browser-check.json](encoding-review/yes-no-app-architecture.browser-check.json)
- [encoding-review/yes-no-app-architecture.finalize-summary.json](encoding-review/yes-no-app-architecture.finalize-summary.json)
- [encoding-review/yes-no-app-architecture.finalize.json](encoding-review/yes-no-app-architecture.finalize.json)
- [enhance.mjs](enhance.mjs)
- [repair-encoding.py](repair-encoding.py)
- [report.mjs](report.mjs)
- [review-2/yes-no-app-architecture.browser-check.json](review-2/yes-no-app-architecture.browser-check.json)
- [review-2/yes-no-app-architecture.finalize-summary.json](review-2/yes-no-app-architecture.finalize-summary.json)
- [review-2/yes-no-app-architecture.finalize.json](review-2/yes-no-app-architecture.finalize.json)
- [review-3/yes-no-app-architecture.browser-check.json](review-3/yes-no-app-architecture.browser-check.json)
- [review-3/yes-no-app-architecture.finalize-summary.json](review-3/yes-no-app-architecture.finalize-summary.json)
- [review-3/yes-no-app-architecture.finalize.json](review-3/yes-no-app-architecture.finalize.json)
- [yes-no-app-architecture.browser-check.json](yes-no-app-architecture.browser-check.json)
- [yes-no-app-architecture.delivery.json](yes-no-app-architecture.delivery.json)
- [yes-no-app-architecture.full-dark.png](yes-no-app-architecture.full-dark.png)
- [yes-no-app-architecture.full-light.png](yes-no-app-architecture.full-light.png)
- [yes-no-app-architecture.html](yes-no-app-architecture.html)
- [yes-no-app-architecture.interaction-check.json](yes-no-app-architecture.interaction-check.json)
- [yes-no-app-architecture.interaction-dark-http.png](yes-no-app-architecture.interaction-dark-http.png)
- [yes-no-app-architecture.interaction-dark-model.png](yes-no-app-architecture.interaction-dark-model.png)
- [yes-no-app-architecture.interaction-light-http.png](yes-no-app-architecture.interaction-light-http.png)
- [yes-no-app-architecture.interaction-light-model.png](yes-no-app-architecture.interaction-light-model.png)
- [yes-no-app-architecture.inventory.json](yes-no-app-architecture.inventory.json)
- [yes-no-app-architecture.json](yes-no-app-architecture.json)
- [yes-no-app-architecture.perceptual-review.json](yes-no-app-architecture.perceptual-review.json)
- [yes-no-app-architecture.report.md](yes-no-app-architecture.report.md)
- [yes-no-app-architecture.source-check.json](yes-no-app-architecture.source-check.json)
- [yes-no-app-architecture.sources.json](yes-no-app-architecture.sources.json)
- [yes-no-app-architecture.visual-check.1440x900.dark.png](yes-no-app-architecture.visual-check.1440x900.dark.png)
- [yes-no-app-architecture.visual-check.1440x900.light.png](yes-no-app-architecture.visual-check.1440x900.light.png)
- [yes-no-app-architecture.visual-check.2048x1320.dark.png](yes-no-app-architecture.visual-check.2048x1320.dark.png)
- [yes-no-app-architecture.visual-check.2048x1320.light.png](yes-no-app-architecture.visual-check.2048x1320.light.png)
- [yes-no-app-architecture.visual-check.html](yes-no-app-architecture.visual-check.html)
- [yes-no-app-architecture.visual-check.json](yes-no-app-architecture.visual-check.json)
