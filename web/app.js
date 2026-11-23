import { Chess, SQUARES } from './assets/chess.js';

const game = new Chess();
const board = document.querySelector('#board');
const status = document.querySelector('#status');
const turnDisc = document.querySelector('#turn-disc');
const moveLog = document.querySelector('#move-log');
const moves = document.querySelector('#moves');
const emptyLog = document.querySelector('#empty-log');
const undo = document.querySelector('#undo');
const flip = document.querySelector('#flip');
const reset = document.querySelector('#reset');
const promotion = document.querySelector('#promotion');

const pieceNames = { k: 'king', q: 'queen', r: 'rook', b: 'bishop', n: 'knight', p: 'pawn' };
const glyphs = { k: '♚', q: '♛', r: '♜', b: '♝', n: '♞', p: '♟' };
const colors = { w: 'White', b: 'Black' };
let flipped = false;
let selected = null;
let focusSquare = 'e2';
let pendingPromotion = null;

const cells = Array.from({ length: 64 }, (_, index) => {
  const button = document.createElement('button');
  button.type = 'button';
  button.className = 'square';
  const piece = document.createElement('span');
  const rank = document.createElement('span');
  const file = document.createElement('span');
  for (const [element, name] of [[piece, 'piece'], [rank, 'rank'], [file, 'file']]) {
    element.className = name;
    element.setAttribute('aria-hidden', 'true');
    button.append(element);
  }
  button.addEventListener('click', () => select(button.dataset.square));
  button.addEventListener('keydown', (event) => navigate(event, index));
  board.append(button);
  return { button, piece, rank, file };
});

function render(focusBoard = false) {
  const history = game.history({ verbose: true });
  const last = history.at(-1);
  const over = game.isGameOver();
  const targets = new Set(selected ? game.moves({ square: selected, verbose: true }).map(move => move.to) : []);
  const check = game.inCheck();
  const turn = game.turn();
  let message = `${colors[turn]} to move${check ? ' · Check' : ''}`;
  if (game.isCheckmate()) message = `Checkmate · ${colors[turn === 'w' ? 'b' : 'w']} wins`;
  else if (game.isStalemate()) message = 'Draw · Stalemate';
  else if (game.isInsufficientMaterial()) message = 'Draw · Insufficient material';
  else if (game.isThreefoldRepetition()) message = 'Draw · Repetition';
  else if (game.isDrawByFiftyMoves()) message = 'Draw · Fifty move rule';
  if (status.textContent !== message) status.textContent = message;
  turnDisc.dataset.color = over ? 'end' : turn;

  cells.forEach(({ button, piece, rank, file }, index) => {
    const square = SQUARES[flipped ? 63 - index : index];
    const occupant = game.get(square);
    const legal = targets.has(square);
    const checked = check && occupant?.type === 'k' && occupant.color === turn;
    button.dataset.square = square;
    button.tabIndex = square === focusSquare ? 0 : -1;
    button.setAttribute('aria-pressed', String(square === selected));
    button.setAttribute('aria-label', [
      square, occupant ? `${colors[occupant.color]} ${pieceNames[occupant.type]}` : 'empty',
      legal ? 'legal move' : '', checked ? 'in check' : '',
    ].filter(Boolean).join(', '));
    button.classList.toggle('square-dark', (Math.floor(index / 8) + index % 8) % 2 === 1);
    button.classList.toggle('square-last', last?.from === square || last?.to === square);
    button.classList.toggle('square-legal', legal && !occupant);
    button.classList.toggle('square-capture', legal && Boolean(occupant));
    button.classList.toggle('square-check', checked);
    piece.textContent = occupant ? glyphs[occupant.type] : '';
    piece.dataset.color = occupant?.color ?? '';
    rank.textContent = index % 8 === 0 ? square[1] : '';
    file.textContent = index >= 56 ? square[0] : '';
    if (focusBoard && square === focusSquare) button.focus({ preventScroll: true });
  });

  if (moves.dataset.plies !== String(history.length)) {
    moves.replaceChildren();
    for (let index = 0; index < history.length; index += 2) {
      const row = document.createElement('li');
      for (const move of history.slice(index, index + 2)) {
        const notation = document.createElement('span');
        notation.textContent = move.san;
        row.append(notation);
      }
      moves.append(row);
    }
    moves.dataset.plies = history.length;
    emptyLog.hidden = history.length > 0;
    moveLog.scrollTop = moveLog.scrollHeight;
  }
  undo.disabled = history.length === 0;
}

function navigate(event, index) {
  const directions = { ArrowLeft: -1, ArrowRight: 1, ArrowUp: -8, ArrowDown: 8 };
  if (!Object.hasOwn(directions, event.key)) return;
  event.preventDefault();
  if ((event.key === 'ArrowLeft' && index % 8 === 0) ||
      (event.key === 'ArrowRight' && index % 8 === 7)) return;
  const next = cells[index + directions[event.key]]?.button;
  if (!next) return;
  cells[index].button.tabIndex = -1;
  focusSquare = next.dataset.square;
  next.tabIndex = 0;
  next.focus();
}

function select(square) {
  focusSquare = square;
  if (game.isGameOver()) {
    render(true);
    return;
  }
  const options = selected && square !== selected
    ? game.moves({ square: selected, verbose: true }).filter(move => move.to === square)
    : [];
  if (options.some(move => move.promotion)) {
    pendingPromotion = { from: selected, to: square };
    promotion.returnValue = '';
    promotion.showModal();
    return;
  }
  if (options.length) {
    game.move({ from: selected, to: square });
    selected = null;
  } else {
    selected = game.get(square)?.color === game.turn() && square !== selected ? square : null;
  }
  render(true);
}

for (const option of promotion.querySelectorAll('button')) {
  option.addEventListener('click', () => promotion.close(option.value));
}

promotion.addEventListener('close', () => {
  if (pendingPromotion && ['q', 'r', 'b', 'n'].includes(promotion.returnValue)) {
    game.move({ ...pendingPromotion, promotion: promotion.returnValue });
    selected = null;
  }
  pendingPromotion = null;
  render(true);
});

undo.addEventListener('click', () => {
  const move = game.undo();
  if (!move) return;
  selected = null;
  focusSquare = move.from;
  render(game.history().length === 0);
});

flip.addEventListener('click', () => {
  flipped = !flipped;
  render();
});

reset.addEventListener('click', () => {
  game.reset();
  selected = null;
  focusSquare = 'e2';
  render(true);
});

render();
flip.disabled = reset.disabled = false;
