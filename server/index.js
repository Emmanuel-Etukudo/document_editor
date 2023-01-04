const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");


const PORT = process.env.PORT | 3001;

const app = express();

const DB = "mongodb+srv://Etukz:Enokudo09@cluster0.dqsfhmo.mongodb.net/?retryWrites=true&w=majority";

app.use(express.json());
app.use(authRouter);

mongoose.connect(DB).then(() => {
    console.log("Connection successful");
}).catch((err) =>{
    console.log(err);
})

app.listen(PORT, "0.0.0.0", () =>{
    console.log(`connected at port ${PORT}`);
});