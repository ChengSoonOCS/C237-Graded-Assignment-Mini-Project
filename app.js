//start the server
const express = require('express');
const mysql = require('mysql2');
const multer = require ("multer")
const app = express();

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "public/images");
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname);
    }
});

const upload = multer({ storage: storage });

// Create MySQL connection
const connection = mysql.createConnection({
host: 'mysql-cheng-soon-db.alwaysdata.net',
user: '370892',
password: 'ChengsoonDBpassword',
database: 'cheng-soon-db_planka'
}); //yoho
connection.connect((err) => {
if (err) {
console.error('Error connecting to MySQL:', err);
return;
}
console.log('Connected to MySQL database');
});

// Set up view engine
app.set('view engine', 'ejs');
// enable static files
app.use(express.static('public'));
// enable form processing
app.use(express.urlencoded({
    extended: false
}));

app.use(express.static("public"))

// Define routes
app.get('/', (req, res) => {
    const sql = 'SELECT * FROM products';
    // Fetch data from MySQL
    connection.query(sql, (error, results) => {
        if (error) {
            console.error("Database query error:", error.message);
            return res.status(500).send("Error Retrieving products");
        }
        // Assuming 'image' field in your database contains the image filename (e.g., 'product123.jpg')
        results.forEach(product => {
            product.image = `/images/${product.image}`; // Adjust the path as needed
        });
        res.render('index', { products: results });
    });
});

    
// connection.query('SELECT * FROM TABLE', (error, results) => {
// if (error) throw error;
// res.render('index', { results }); // Render HTML page with data
// });
// });

app.get("/product/:id", (req, res) => {
    // Extract the product ID from the request parameters
    const productId = req.params.id;
    const sql = "SELECT * FROM products WHERE productId = ?";
    // Fetch data from SQL based on the product ID
    connection.query(sql, [productId], (error, results) => {
        if (error) {
            console.error("Database query error:", error.message);
            return res.status(500).send("Error Retrieving product by ID");
        }
        // Check if any product with the given ID was found
        if (results.length > 0) {
            // Assuming the 'image' field in your database contains the image filename (e.g., 'product123.jpg')
            const product = results[0];
            product.image = `/images/${product.image}`; // Adjust the path as needed

            // Render HTML page with the product data
            res.render("product", { product });
        } else {
            // If no product with the given ID was found, render a 404 page or handle it accordingly
            res.status(404).send("Product not found");
        }
    });
});


app.get("/addProduct", (req, res) => {
    res.render("addProduct");
});

app.post("/addProduct", upload.single("image"),(req, res) => {
    const {name, quantity, price} = req.body;
    let image;
    if (req.file) {
        image = req.file.filename;
    } else {
        image = null;
    }           
    
    const sql = "INSERT INTO products (product_name, minting_timestamp, description, owner_first_name, owner_last_name, base_price, selling_price, image, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    //Insert the new product into the database
    connection.query(sql, [name, TimeStamp, description, fname, lname, Bprice, Sprice, image, quantity], (error, results) => {
        if (error) {
            console.error("Error adding product:", error);
            res.status(500).send("Error adding Product");
        } else {
            res.redirect("/");
        }
    });
});

app.get("/updateProduct/:id", (req, res) => {
    const productId = req.params.id;
    const sql = "SELECT * FROM products WHERE productId =?";
    // Fetch data from SQL based on the product ID
    connection.query( sql, [productId], (error, results) => {
        if (error) {
            console.error("Database query error:", error.message);
            return res.status(500).send("Error Retrieving product by ID");
        }
        // check if any product with the given ID was found
        if (results.length > 0) {
            // Render HTML page with the product data
            res.render("updateProduct", {product: results[0] });
        } else {
            // If no product with the given ID was found, render a 404 page or handle it accordingly
            res.status(404).send("Product not found");
        }
    });
});

app.post("/updateProduct/:id", upload.single("image"),(req, res) => {
    const productId = req.params.id;
    //Extract product data from the request body
    const { name, quantity, price } = req.body;
    let image = req.body.currentImage;
    if (req.file) {
        image = req.file.filename;
    }

    const sql = "UPDATE products SET productName = ?, quantity = ?, price = ?, image =? WHERE productId = ?";

    // inster the new product into the database
    connection.query(sql, [name, quantity, price, image, productId], (error, results) => {
        if (error) {
            console.error("Error updating product:", error);
            res.status(500).send("Error updating Product");
        } else {
            // Send a success response
            res.redirect("/");
        }
    });
});



app.get("/deleteProduct/:id", (req, res) => {
    const productId = req.params.id;
    const sql = "DELETE FROM products WHERE productId = ?";
    connection.query(sql, [productId], (error, results) => {
        if (error) {
            console.error("Error deleting product:", error);
            res.status(500).send("Error deleting Product");
        } else {
            res.redirect("/");
        }
    });
});



const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));