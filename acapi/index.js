const express = require('express')
const mysql2  = require('mysql2')

const app = express()

const PORT = process.env.port || 8080

const db_user     = process.env.db_user     || 'root'
const db_host     = process.env.db_host     || 'localhost'
const db_password = process.env.db_password || ''
const db_database = process.env.db_database || 'accenture'

function create_database_connection(){
    const con = mysql2.createConnection({
        host: db_host,
        user: db_user,
        db_database: db_database,
        db_password: db_password
    })

    return con
}


app.get('/test', (req, res) => {
    res.send('Success')
})

app.get('/machine_status', (req, ers) => {
    con = create_database_connection()
})

app.get('/load/{machine_id}', (req, res) => {
    res.send(machine_id)
})

app.listen(PORT, () => {
    console.log(`App started on port ${PORT}`)
})
