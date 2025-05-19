const express = require('express');
const app = express();
const port = 3000;

// Endpoint /travel
app.get('/travel', (req, res) => {
  // Muuda "Jaapan" oma tegelikuks lemmikuks sihtkohaks!
  res.send('Minu lemmik reisisihtkoht on Jaapan.');
});

app.listen(port, () => {
  console.log(`Rakendus kuulab pordil ${port}`);
});
