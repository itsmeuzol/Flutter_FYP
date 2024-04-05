const { Router } = require("express");
const router = Router();

const mysqlConnection = require("../database/database");

router.get("/", (req, res) => {
  res.status(200).json("Server on port 8000 and database is connected");
});

router.get("/::users", (req, res) => {
  mysqlConnection.query("SELECT * FROM user", (error, rows, fields) => {
    if (!error) {
      res.json(rows);
    } else {
      console.log(error);
    }
  });
});

router.get("/:users:id", (req, res) => {
  const { id } = req.params;
  mysqlConnection.query(
    "SELECT * FROM user WHERE id IS NOT NUll",
    [id],
    (error, rows, fields) => {
      if (!error) {
        res.json(rows);
      } else {
        console.log(error);
      }
    }
  );
});

router.post("/:users", (req, res) => {
  const { id, full_name, location, houseno, wardno, email, password } =
    req.body;
  console.log(req.body);
  mysqlConnection.query(
    "INSERT INTO user(id,full_name,location,houseno,wardno,email,password) VALUES(?,?,?,?,?,?,?)",
    [id, full_name, location, houseno, wardno, email, password],
    (error, rows, fields) => {
      if (!error) {
        res.json({ Status: "User Added Successfully" });
      } else {
        console.log(error);
      }
    }
  );
});

router.put("/:users:id", (req, res) => {
  const { id, full_name, location, houseno, wardno, email, password } =
    req.body;
  console.log(req.body);
  mysqlConnection.query(
    "UPDATE user SET full_name=?,location=?,houseno=?,wardno=?,email=?,password=? WHERE id = ?",
    [full_name, location, houseno, wardno, email, password, id],
    (error, rows, fields) => {
      if (!error) {
        res.json({ Status: "User Updated Successfully" });
      } else {
        console.log(error);
      }
    }
  );
});

router.delete("/:users/:id", (req, res) => {
  const { id } = req.params;
  mysqlConnection.query(
    "DELETE FROM user WHERE id IS NOT NUll",
    [id],
    (error, rows, fields) => {
      if (!error) {
        res.json({ Status: "User Deleted Successfully" });
      } else {
        res.json({ Status: error });
        console.log(error);
      }
    }
  );
});

module.exports = router;
