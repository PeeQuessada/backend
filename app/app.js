const express = require("express");
const { Client } = require('pg');
const format = require('pg-format');

/* -------------------------------------------------------------------------- */
// Configurações para a conexão com o banco de dados
const dbConfig = {
    user: 'postgres',
    host: '34.133.40.179',
    database: 'testbd-database',
    password: 'admin',
    port: 5432, // Porta padrão do PostgreSQL
};

// Criação de um cliente PostgreSQL
const client = new Client(dbConfig);

// Função para conectar-se ao banco de dados
async function connectToDatabase() {
    try {
      await client.connect();
      console.log('Conectado ao banco de dados PostgreSQL');
    } catch (error) {
      console.error('Erro ao conectar-se ao banco de dados', error);
    } finally {
      // Certifique-se de fechar a conexão após usar
      // await client.end();
    }

    try {
        await insertContact('John Doe', 'john.doe@example.com');
        console.log('Conectado ao banco de dados PostgreSQL');
      } catch (error) {
        console.error('EErro ao inserir linha na tabela', error);
      } finally {
        // Certifique-se de fechar a conexão após usar
        // await client.end();
      }
}
  
// Exemplo de uso da função de conexão
connectToDatabase();

/* -------------------------------------------------------------------------- */
const app = express();
app.use(express.json());

const fakeBD = [];

app.get("/", (req, res, next) => {
    res.send("Hello world from Google Cloud Plataform and Github Actions 2");
});


app.get("/get", async (req, res, next) => {
    res.status(200).json(fakeBD);
});

app.post("/create", async (req, res, next) => {
    try {
        const newRecord = req.body;

        if(!newRecord) {
            return res.status(400).json({message: "Error"});
        }
        console.log('newRecord:', newRecord.name);
        fakeBD.push(newRecord);
        await insertContact(newRecord.name, newRecord.email);
        res.status(200).json({message: "record created successfully"});
    } catch (error) {
        res.status(500).json({message: error});
    }
});

app.put("/update/:id", async (req, res, next) => {
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

app.delete("/delete/:id", async (req, res, next) => {
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

const port = process.env.PORT || 3001;
app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});


/* -------------------------------------------------------------------------- */
// Função para inserir uma linha na tabela contact
async function insertContact(name, email) {
    const query = 'INSERT INTO contact(name, email) VALUES($1, $2)';
    const values = [name, email];

    console.log('Query:', query);
    console.log('values:', values);
  
    try {
      const result = await client.query(query, values);
      console.log('Linha inserida com sucesso:', result.rows[0]);
    } catch (error) {
      console.error('Erro ao inserir linha na tabela', error);
    }
}