const express = require('express');
const mysql = require('mysql2');
const multer = require('multer');
const app = express();
const port = 3001;

// Buat koneksi ke database MySQL
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root', // Ganti dengan username MySQL Anda
  password: '', // Ganti dengan password MySQL Anda
  database: 'akar_hijau' // Ganti dengan nama database yang ingin Anda gunakan
});

// Cek koneksi ke database
db.connect((err) => {
  if (err) throw err;
  console.log('Database connected');
});

// Middleware untuk parse body request
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Setup multer untuk upload gambar
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });


// Routes
// Contoh route untuk mendapatkan semua data

app.get('/api/data', (req, res) => {
  db.query('SELECT * FROM users', (err, results) => {
    if (err) {
      console.error('Error retrieving data:', err);
      return res.status(500).json({ error: 'Gagal mengambil data' });
    }
    return res.status(200).json(results);
  });
});

app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  
  // Query ke database untuk memeriksa kredensial
  db.query('SELECT * FROM users WHERE username = ? AND password = ?', [username, password], (err, results) => {
    if (err) {
      console.error('Error retrieving data:', err);
      return res.status(500).json({ error: 'Terjadi kesalahan pada server' });
    }

    if (results.length === 0) {
      // Jika tidak ada pengguna dengan kredensial yang diberikan
      return res.status(401).json({ error: 'Kredensial salah' });
    }

    // Jika kredensial benar, beri respons berhasil
    return res.status(200).json({ message: 'Login berhasil' });
  });
});



// Contoh route untuk menambahkan data baru
app.post('/api/add', (req, res) => {
  const { username, password, name, level, email } = req.body;
  const sql = `INSERT INTO users (username, password, name, level, email) VALUES (?, ?, ?, ?, ?)`;
const values = [username, password, name, level, email];
  
  db.query(sql, values, (err, result) => {
    if (err) {
      console.error('Error adding data:', err);
      return res.status(500).json({ error: 'Gagal menambahkan data' });
    }
    return res.status(200).json({ message: 'Data added successfully' });
  });
});

// update
app.put('/api/update/:id', (req, res) => {
  const id_user = req.params.id;
  const { username, password, name, level, email } = req.body;

  // Validasi input
  if (!username || !password || !name || !level || !email) {
    return res.status(400).json({ error: 'Semua field harus diisi' });
  }

  const sql = `UPDATE users SET username = ?, password = ?, name = ?, level = ?, email = ? WHERE id = ?`;
  const values = [username, password, name, level, email, id_user];
  
  db.query(sql, values, (err, result) => {
    if (err) {
      console.error('Error updating data:', err);
      return res.status(500).json({ error: 'Gagal mengupdate data' });
    }
    return res.status(200).json({ message: 'Data updated successfully' });
  });
});

app.delete('/api/delete/:id', (req, res) => {
  const id_user = req.params.id;

  const sql = `DELETE FROM users WHERE id = ?`; // Ubah 'id' sesuai dengan nama kolom yang benar
  const values = [id_user];
  
  db.query(sql, values, (err, result) => {
    if (err) {
      console.error('Error deleting data:', err);
      return res.status(500).json({ error: 'Gagal menghapus data' });
    }
    return res.status(200).json({ message: 'Data deleted successfully' });
  });
});

// Postingan
app.get('/api/search', (req, res) => {
  db.query('SELECT posting_title, author, equipment, steps FROM post', (err, results) => {
    if (err) {
      console.error('Error retrieving data:', err);
      return res.status(500).json({ error: 'Gagal mengambil data' });
    }
    return res.status(200).json(results);
  });
});

// Contoh route untuk menambahkan data baru
app.post('/api/add_post', (req, res) => {
  const { posting_title, author, equipment, steps } = req.body;
  const sql = `INSERT INTO post (posting_title, author, equipment, steps) VALUES (?, ?, ?, ?)`;
const values = [posting_title, author, equipment, steps];
  
  db.query(sql, values, (err, result) => {
    if (err) {
      console.error('Error adding data:', err);
      return res.status(500).json({ error: 'Gagal menambahkan data' });
    }
    return res.status(200).json({ message: 'Data added successfully' });
  });
});

// Jalankan server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});