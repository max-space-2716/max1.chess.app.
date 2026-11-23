import { cp, mkdir, readFile, rm, writeFile } from 'node:fs/promises';

const dist = new URL('../dist/', import.meta.url);
const assets = new URL('./assets/', dist);
const chess = new URL('../node_modules/chess.js/', import.meta.url);

await rm(dist, { force: true, recursive: true });
await cp(new URL('../web/', import.meta.url), dist, { recursive: true });
await mkdir(assets);
const engine = await readFile(new URL('./dist/esm/chess.js', chess), 'utf8');
await writeFile(new URL('./chess.js', assets), engine.replace(/^\/\/# sourceMappingURL=.*$/m, ''));
await cp(new URL('./LICENSE', chess), new URL('./chess-LICENSE.txt', assets));
