# Kasuta ametlikku Node.js baasimaget
FROM node:18-alpine

# Määra töökataloog konteineris
WORKDIR /usr/src/app

# Kopeeri package.json ja package-lock.json (kui on olemas)
COPY package*.json ./

# Paigalda rakenduse sõltuvused
RUN npm install

# Kopeeri ülejäänud rakenduse lähtekood
COPY . .

# Ava port 3000, mida rakendus kasutab
EXPOSE 3000

# Käivita rakendus, kui konteiner stardib
CMD [ "npm", "app.js" ]
