import { State } from 'activestate'
import Big from 'big.js';

export function currentPrice(base, quote = 'eur') {
  const direct = State.prices?.[`${base}-${quote}`];
  if (direct && direct.length) {
    return direct.slice(-1)[0][1] || 0;
  }
  const inverse = State.prices?.[`${quote}-${base}`];
  if (inverse && inverse.length) {
    const price = inverse.slice(-1)[0][1];
    return price ? Big(1).div(price).toNumber() : 0;
  }
  return 0;
}

export function convert(amount, fromSymbol, toSymbol) {
  if (fromSymbol === toSymbol) return amount;
  const price = currentPrice(fromSymbol, toSymbol);
  if (!price) return 0;
  const result = Big(amount).times(price).round(8)
  return result
}
