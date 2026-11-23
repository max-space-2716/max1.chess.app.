<!-- coderabbit-ai-generated:v1 -->

# MAX Chess browser deployment

The `web/` app is a standalone board for two people playing on one device. It has no sign-in, backend calls, wallet, third-party browser assets, or media. The Flutter and Firebase files are a separate source bundle; the browser build does not include them.

<!-- coderabbit-ai-generated:v1 -->

<!-- coderabbit-ai-generated-section:v1:141429345a0a31be44534f4b62d896b3bbc2b765ec3182fbf2adb9c620e49b59 -->

## Cloudflare deployment

The live site is [MAX Chess](https://max1-chess-app.pages.dev/). The production URL serves the prepared static build over Cloudflare HTTPS. Verify the iframe on the actual portal before marking the mount wired.

<!-- coderabbit-ai-generated:v1 -->

<!-- coderabbit-ai-generated-section:v1:4dfec6470c06059e658fb1db7808efe8da273e5501fb5b2cd1723fee3eb62dcc -->

If this Pages project uses Direct Upload, update it in a browser: open it in [Workers & Pages](https://dash.cloudflare.com/?to=/:account/workers-and-pages), select **Create a new deployment**, and upload the ZIP or folder containing the built files at its root. See [Cloudflare’s Direct Upload guide](https://developers.cloudflare.com/pages/get-started/direct-upload/#create-a-new-deployment).

<!-- /coderabbit-ai-generated:v1 -->

For a rebuild, run `npm ci --ignore-scripts` and `npm run build` (tested with Node 24). Upload the contents of `dist/`. To develop locally, run `npm run preview` after building and open the URL it prints. The pinned [chess.js rules engine](https://github.com/jhlywa/chess.js/tree/v1.4.0) and its license are copied into the build.

<!-- /coderabbit-ai-generated:v1 -->

## Mount in the MAX Chess view

<!-- coderabbit-ai-generated:v1 -->

<!-- coderabbit-ai-generated-section:v1:5de22e88ced150586dd8889771c163ad69726036280322ff40acb4a428743bb1 -->

Use a cross-origin iframe in the public Chess view:

```html
<a href="https://max1-chess-app.pages.dev/" target="_blank" rel="noopener noreferrer">
  Open MAX Chess in a new tab
</a>
<iframe
  class="max-chess-frame"
  src="https://max1-chess-app.pages.dev/"
  title="MAX Chess"
  sandbox="allow-scripts allow-same-origin"
  referrerpolicy="no-referrer">
</iframe>
```

<!-- /coderabbit-ai-generated:v1 -->

Give the iframe the full available width and height inside the Chess viewport, with scrolling available in the frame when the view is short. Keep the direct link visible outside the frame so it still works when embedding is blocked. If the portal uses a Content Security Policy, allow the Pages origin in its `frame-src`. The [Pages `_headers` file](https://developers.cloudflare.com/pages/configuration/headers/) permits HTTPS ancestors and keeps asset requests on the app’s own origin. When the portal and any outer shell origins are known, replace `https:` in `frame-ancestors` with those exact HTTPS origins and redeploy.

Mount the iframe only while Chess is active. On every switch among Chess, Sports, Art, Overview, Media, Games, and MAX-SIM, run the outgoing view’s media and viewport cleanup and remove its elements. For Chess, remove the iframe itself; hiding it keeps its document and game alive. Re-entering Chess creates a fresh document. Keep Command (Page 1) private and outside the public frame mounts. The portal repository is required to wire and verify these transitions.

## Traffic and dependencies

<!-- coderabbit-ai-generated:v1 -->

<!-- coderabbit-ai-generated-section:v1:0be2d8863eed3ee5b2deca0bb1832ab8b7ef5517a93978c5154bc3f2b0fc527b -->

<!-- coderabbit-ai-generated-section:v1:63b3540ad69e0aafcbec7efac90e2351dadb490aa49d4cf7a494d52e99ac228c -->

Public Chess traffic uses Cloudflare HTTPS: [max1-chess-app.pages.dev](https://max1-chess-app.pages.dev/).

<!-- /coderabbit-ai-generated:v1 -->

The MAX Chess portal mount and remote feeds remain `unwired_honest`. P-STEP/1.0 and MAX-TELECOM remain `planned`.

<!-- /coderabbit-ai-generated:v1 -->

Portal defaults stay `PUBLIC_MAX_INTERNET_FREE = "true"` and `WALLET_MODE_DEFAULT = "opt-in"`. This static deployment needs no R2, Stripe, Bitcoin, or wallet service. Base Mainnet USDC (chain `8453`) remains a future opt-in path.
