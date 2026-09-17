class Calculator {
  constructor() { this.clear(); }
  clear() { this.value = '0'; this.previous = null; this.operator = null; this.fresh = true; this.expression = ''; }
  digit(digit) {
    if (this.value === 'Error') this.clear();
    if (this.fresh) { this.value = digit === '.' ? '0.' : digit; this.fresh = false; if (!this.operator) this.expression = ''; return; }
    if (digit === '.' && this.value.includes('.')) return;
    if (this.value.replace(/[-.]/g, '').length >= 12) return;
    this.value = this.value === '0' && digit !== '.' ? digit : this.value + digit;
  }
  symbol(operator) { return ({ '+': '+', '-': '−', '*': '×', '/': '÷' })[operator]; }
  choose(operator) {
    if (this.value === 'Error') return;
    if (this.operator && !this.fresh) this.equals();
    if (this.value === 'Error') return;
    this.previous = Number(this.value); this.operator = operator; this.fresh = true;
    this.expression = `${this.value} ${this.symbol(operator)}`;
  }
  equals() {
    if (!this.operator || this.value === 'Error') return;
    const a = this.previous, b = Number(this.value), op = this.operator;
    this.expression = `${a} ${this.symbol(op)} ${this.value} =`;
    const result = op === '+' ? a + b : op === '-' ? a - b : op === '*' ? a * b : b === 0 ? NaN : a / b;
    this.value = Number.isFinite(result) ? String(Number(result.toPrecision(12))) : 'Error';
    if (!Number.isFinite(result)) this.expression = b === 0 && op === '/' ? 'Cannot divide by zero' : 'Result is too large';
    this.previous = null; this.operator = null; this.fresh = true;
  }
  sign() { if (this.value === 'Error' || Number(this.value) === 0) return; this.value = this.value.startsWith('-') ? this.value.slice(1) : '-' + this.value; this.fresh = false; if (!this.operator) this.expression = ''; }
  backspace() { if (this.value === 'Error') return this.clear(); if (this.fresh) return; this.value = this.value.slice(0, -1); if (this.value === '' || this.value === '-') this.value = '0'; }
}
if (typeof module !== 'undefined') module.exports = Calculator;
