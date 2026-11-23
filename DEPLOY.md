<!-- coderabbit-ai-generated:v1 -->

# MAX Chess browser deployment

The `web/` app is a standalone board for two people playing on one device. It has no sign-in, backend calls, wallet, third-party browser assets, or media. The Flutter and Firebase files are a separate source bundle; the browser build does not include them.

## Publish without a terminal

1. Download `max-chess-cloudflare-pages.zip` from the task’s Outputs. It contains `index.html` and `_headers` at the root.
2. In the [Cloudflare dashboard](https://dash.cloudflare.com/?to=/:account/workers-and-pages), open **Workers & Pages** → **Create application** → **Get started** → **Drag and drop your files**. Name a Pages project, drop in the ZIP, and choose **Deploy site**. See [Cloudflare’s Direct Upload guide](https://developers.cloudflare.com/pages/get-started/direct-upload/#drag-and-drop).
3. Open the `https://…pages.dev/` address Cloudflare assigns and play a move. Use that exact production address for the portal iframe and direct link. Verify the iframe on the actual portal before marking it wired.

For a rebuild, run `npm ci --ignore-scripts` and `npm run build` (tested with Node 24). Upload the contents of `dist/`. To develop locally, run `npm run preview` after building and open the URL it prints. The pinned [chess.js rules engine](https://github.com/jhlywa/chess.js/tree/v1.4.0) and its license are copied into the build.

## Mount in the MAX Chess view

Use a cross-origin iframe in the public Chess view. Replace both instances of the sample URL with the assigned HTTPS URL:

```html
<a href="https://YOUR-PROJECT.pages.dev/" target="_blank" rel="noopener noreferrer">
  Open MAX Chess in a new tab
</a>
<iframe
  class="max-chess-frame"
  src="https://YOUR-PROJECT.pages.dev/"
  title="MAX Chess"
  sandbox="allow-scripts allow-same-origin"
  referrerpolicy="no-referrer">
</iframe>
```

Give the iframe the full available width and height inside the Chess viewport, with scrolling available in the frame when the view is short. Keep the direct link visible outside the frame so it still works when embedding is blocked. If the portal uses a Content Security Policy, allow the Pages origin in its `frame-src`. The [Pages `_headers` file](https://developers.cloudflare.com/pages/configuration/headers/) permits HTTPS ancestors and keeps asset requests on the app’s own origin. When the portal and any outer shell origins are known, replace `https:` in `frame-ancestors` with those exact HTTPS origins and redeploy.

Mount the iframe only while Chess is active. On every switch among Chess, Sports, Art, Overview, Media, Games, and MAX-SIM, run the outgoing view’s media and viewport cleanup and remove its elements. For Chess, remove the iframe itself; hiding it keeps its document and game alive. Re-entering Chess creates a fresh document. Keep Command (Page 1) private and outside the public frame mounts. The portal repository is required to wire and verify these transitions.

## Traffic and dependencies

| Surface | Status |
| --- | --- |
| Public Chess traffic | Cloudflare HTTPS is the intended route. `unwired_honest` until the production Pages URL is deployed and verified. |
| MAX Chess portal mount and remote feeds | `unwired_honest` |
| P-STEP/1.0 and MAX-TELECOM | `planned` |

Portal defaults stay `PUBLIC_MAX_INTERNET_FREE = "true"` and `WALLET_MODE_DEFAULT = "opt-in"`. This static deployment needs no R2, Stripe, Bitcoin, or wallet service. Base Mainnet USDC (chain `8453`) remains a future opt-in path.
