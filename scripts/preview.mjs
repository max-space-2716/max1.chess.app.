import { readFile } from 'node:fs/promises';
import { createServer } from 'node:http';
import { extname } from 'node:path';

const port = Number(process.env.PORT ?? 4173);
const dist = new URL('../dist/', import.meta.url);
const rules = await readFile(new URL('_headers', dist), 'utf8');
const headers = Object.fromEntries([...rules.matchAll(/^ +([\w-]+): (.+)$/gm)]
  .map(([, name, value]) => [name, value]));
const types = {
  '.html': 'text/html; charset=utf-8',
  '.js': 'text/javascript; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.svg': 'image/svg+xml',
  '.txt': 'text/plain; charset=utf-8',
};

createServer(async (request, response) => {
  const path = new URL(request.url, 'http://localhost').pathname;
  const file = path === '/' ? '/index.html' : path;
  const type = types[extname(file)];
  // Only the public root and its assets directory are served.
  if (!/^\/(?:assets\/)?[\w.-]+$/.test(file) || !type) {
    response.writeHead(404).end();
    return;
  }
  try {
    const contents = await readFile(new URL(file.slice(1), dist));
    response.writeHead(200, { ...headers, 'Content-Type': type, 'Cache-Control': 'no-store' }).end(contents);
  } catch {
    response.writeHead(404).end();
  }
}).listen(port, '0.0.0.0', () => console.log(`MAX Chess preview: http://localhost:${port}`));
