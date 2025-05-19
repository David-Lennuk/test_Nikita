# Kasuta ametlikku Node.js baasimaget
FROM node:18

# Määra töökataloog konteineris
WORKDIR app

# Paigalda rakenduse sõltuvused
RUN npm install

# Kopeeri ülejäänud rakenduse lähtekood
COPY . .

# Ava port 3000, mida rakendus kasutab
EXPOSE 3000

# Käivita rakendus, kui konteiner stardib
CMD [ "node", "app.js" ]
