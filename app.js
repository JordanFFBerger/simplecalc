const calculator = new Calculator();
const result = document.getElementById('result');
const expression = document.getElementById('expression');
function render() {
  result.textContent = calculator.value;
  result.classList.toggle('small', calculator.value.length > 10);
  expression.textContent = calculator.expression || '\u00a0';
  document.querySelectorAll('[data-operator]').forEach(button => button.setAttribute('aria-pressed', String(button.dataset.operator === calculator.operator)));
}
document.querySelector('.keypad').addEventListener('click', event => {
  const button = event.target.closest('button');
  if (!button) return;
  if (button.dataset.digit !== undefined) calculator.digit(button.dataset.digit);
  else if (button.dataset.operator) calculator.choose(button.dataset.operator);
  else calculator[button.dataset.action]();
  render();
});
document.addEventListener('keydown', event => {
  if (event.ctrlKey || event.metaKey || event.altKey) return;
  if (event.key === 'Enter' && document.activeElement.tagName === 'BUTTON') return;
  if (/^[0-9.]$/.test(event.key)) calculator.digit(event.key);
  else if (['+', '-', '*', '/'].includes(event.key)) calculator.choose(event.key);
  else if (event.key === 'Enter' || event.key === '=') calculator.equals();
  else if (event.key === 'Escape' || event.key.toLowerCase() === 'c') calculator.clear();
  else if (event.key === 'Backspace') calculator.backspace();
  else return;
  event.preventDefault(); render();
});
render();
