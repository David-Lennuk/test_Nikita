const express = require('express');
const app = express();
const port = 3000;

app.get('/travel', (req, res) => {
  res.send('Minu lemmik reisisihtkoht on Jaapan.');
});

app.listen(port, () => {
  console.log(`Rakendus kuulab pordil ${port}`);
});
