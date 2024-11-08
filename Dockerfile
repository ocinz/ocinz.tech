# Menggunakan image Node.js yang sudah ada
FROM node:18-alpine

# Menentukan direktori kerja di dalam container
WORKDIR /app

# Menyalin package.json dan package-lock.json ke dalam container
COPY package*.json ./

# Menginstal dependencies
RUN npm install

# Menyalin seluruh kode sumber aplikasi
COPY . .

# Menyusun aplikasi untuk production
RUN npm run build

# Menyediakan aplikasi pada port 3000
EXPOSE 3000

# Menjalankan aplikasi dengan perintah npm start
CMD ["npm", "start"]
