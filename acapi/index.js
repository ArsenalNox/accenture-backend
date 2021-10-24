const express = require('express')
const mysql2  = require('mysql2')
const cors    = require('cors')
    
const app = express()

app.use(cors())

const PORT = process.env.port || 8080

const db_user     = process.env.db_user     || 'root'
const db_host     = process.env.db_host     || 'localhost'
const db_password = process.env.db_password || 'root'
const db_database = process.env.db_database || 'accenture'

function create_database_connection(){
    const con = mysql2.createConnection({
        host: db_host,
        user: db_user,
        database: db_database,
        password: db_password
    })

    return con
}


app.get('/test', (req, res) => {
    res.send('Success')
})

app.get('/machine_status', (req, res) => {
    //Получение статуса всех ресурсов 
    con = create_database_connection()

    con.query(`
    SELECT 
        resources.*, 
        avg(work.occupiedPercent) as 'occupiedPercent'
    FROM resources 
    LEFT JOIN work ON work.resourcefk=resources.id 
    GROUP BY resources.id;`, 
    (err, result) => {

        if (err){
            throw err
        }
        res.send(result)

        console.log(result)
    })

})

app.get('/info/:machine_id', (req, res) => {
    //Получение статуса конкретной машины
    machine_id = req.params.machine_id
    con = create_database_connection()
    con.query(`
        SELECT 
            resources.name as 'machine_name',
            resources.fid  as 'machine_factory_id',
            groups.fid     as 'group_factory_id',
            groups.name    as 'group_factory_name',
            shops.fid      as 'shop_factory_id',
            shops.name     as 'shop_factory_name'
        FROM resources
        LEFT JOIN groups ON resources.groupfk=groups.id
        LEFT JOIN shops ON groups.shopfk=shops.id
        WHERE resources.id = ?
        `, [machine_id], (err, result) => {
            if (err){
                throw err 
            }
            res.send(result)
        })
})

app.get('/get_warehouses', (req, res) => {
    //Получает статус всех складов 
})

app.listen(PORT, () => {
    console.log(`App started on port ${PORT}`)
})
