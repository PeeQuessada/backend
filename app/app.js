const express = require("express");

const app = express();
app.use(express.json());

const fakeBD = [];

app.get("/", (req, res, next) => {
    res.send("Hello world from Terrafrom");
});


app.get("/get", (req, res, next) => {
    res.status(200).json(fakeBD);
});

app.post("/create", (req, res, next) => {
    try {
        const newRecord = req.body;

        if(!newRecord) {
            return res.status(400).json({message: "Error"});
        }
    
        fakeBD.push(newRecord);
    
        res.status(200).json({message: "record created successfully"});
    } catch (error) {
        res.status(500).json({message: error});
    }
});

app.put("/update/:id", (req, res, next) => {
    try {
        const id = req.params.id;
        const index = id - 1;
        if(fakeBD.length <= index|| id == 0) {
            return res.status(400).json({message: "Error invalid ID"});
        }
    
        const newRecord = req.body;
        if(!newRecord) {
            return res.status(400).json({message: "Error"});
        }
    
        fakeBD[index] = newRecord;
    
        res.status(200).json({message: "Record updated successfully"});
    } catch (error) {
        res.status(500).json({message: error});
    }
});

app.delete("/delete/:id", (req, res, next) => {
    try {
        const id = req.params.id;
        const index = id - 1;

        if(fakeBD.length <= index || id == 0) {
            return res.status(400).json({message: "Error invalid ID"});
        }
    
        fakeBD.splice(index, 1);
    
        res.status(200).json({message: "Record deleted successfully"});
    } catch (error) {
        res.status(500).json({message: error});
    }
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});