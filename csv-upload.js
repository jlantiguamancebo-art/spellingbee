(function () {
  const input = document.getElementById('csvUpload');
  if (!input) return;

  const aliases = {
    word: ['complete word', 'palabra completa'],
    sentence: ['sentence', 'frase'],
    d1: ['distractor 1'],
    d2: ['distractor 2'],
    pattern: ['word with blank', 'palabra con espacio'],
    opts: ['options', 'opciones']
  };

  function parseCsv(text) {
    const rows = [];
    let row = [], cell = '', quoted = false;
    text = text.replace(/^\uFEFF/, '');
    for (let i = 0; i < text.length; i += 1) {
      const ch = text[i];
      if (ch === '"') {
        if (quoted && text[i + 1] === '"') { cell += '"'; i += 1; }
        else quoted = !quoted;
      } else if (ch === ',' && !quoted) {
        row.push(cell); cell = '';
      } else if ((ch === '\n' || ch === '\r') && !quoted) {
        if (ch === '\r' && text[i + 1] === '\n') i += 1;
        row.push(cell); cell = '';
        if (row.some(value => value.trim() !== '')) rows.push(row);
        row = [];
      } else cell += ch;
    }
    row.push(cell);
    if (row.some(value => value.trim() !== '')) rows.push(row);
    return rows;
  }

  function normalized(value) {
    return String(value || '').trim().toLowerCase();
  }

  function columnMap(headers) {
    const normalizedHeaders = headers.map(normalized);
    const map = {};
    Object.entries(aliases).forEach(([name, accepted]) => {
      map[name] = normalizedHeaders.findIndex(header => accepted.includes(header));
    });
    const missing = Object.entries(map).filter(([, index]) => index < 0).map(([name]) => name);
    if (missing.length) throw new Error(`Faltan columnas: ${missing.join(', ')}.`);
    return map;
  }

  function fillForm(rows, map) {
    const tableRows = [...document.querySelectorAll('#wordRows tr')];
    if (tableRows.length !== 20) throw new Error('El formulario todavía no está listo. Intenta de nuevo.');
    rows.forEach((csvRow, index) => {
      const formRow = tableRows[index];
      Object.entries(map).forEach(([field, column]) => {
        const element = formRow.querySelector(`[data-field="${field}"]`);
        element.value = String(csvRow[column] || '').trim();
        element.dispatchEvent(new Event('input', { bubbles: true }));
      });
    });
    document.getElementById('currentCount').textContent = '20 de 20 palabras';
  }

  input.addEventListener('change', () => {
    const file = input.files && input.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = () => {
      try {
        const parsed = parseCsv(reader.result);
        if (parsed.length !== 21) throw new Error(`El CSV debe tener encabezado y exactamente 20 palabras; encontré ${Math.max(0, parsed.length - 1)}.`);
        const map = columnMap(parsed[0]);
        const rows = parsed.slice(1);
        if (rows.some(row => !String(row[map.word] || '').trim())) throw new Error('Hay una fila sin palabra completa.');
        fillForm(rows, map);
        status(`CSV cargado correctamente: 20 palabras listas para revisar y guardar.`);
      } catch (error) {
        status(error.message || 'No se pudo leer el CSV.', true);
      } finally {
        input.value = '';
      }
    };
    reader.onerror = () => { status('No se pudo leer el archivo CSV.', true); input.value = ''; };
    reader.readAsText(file, 'UTF-8');
  });
}());
