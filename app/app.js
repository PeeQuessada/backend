var express = require("express");
var app = express();
var port = process.env.PORT || 3000;

app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});

app.get("/", (req, res, next) => {
    res.json(`{ code: 200, message: 'sucesso', port: ${port} }`
    );
});

app.get("/get", (req, res, next) => {
    res.json(["teste", "teste2"]);
});