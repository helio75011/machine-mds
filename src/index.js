import express from 'express'
const app = express();
const PORT = 5000;

app.get('/', (req,res) => {
    res.send("hello world")
})

app.get('/json', (req,res) => {
    res.json("azerty","uiop","qsdfg")
})
app.listen(PORT, () => {
    console.log(`server running on port ${PORT}`)
})