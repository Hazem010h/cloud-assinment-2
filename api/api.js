const e = require('express');
const express = require('express');
const cors = require('cors');
const PORT=5000;

const fs = require('fs')
const readline = require('readline')
var dataFile="data/persons.txt"

var personsArr=[];
read()

const app = express();
app.listen(PORT);
app.use(cors({
    origin: '*',
    methods: ['GET','POST','DELETE','UPDATE','PUT','PATCH']
}));
app.use(express.json());

app.get('/persons', async (req, res) => {
    try {
        res.send(personsArr);
    }
    catch (error) {
        res.status(500).send(error.message);
    }
});

app.get('/persons/:id', async (req, res) => {
    try {
        index=personsArr.findIndex((obj=>obj.id==req.params.id))
        if(index==-1)throw 'no person with this id'
        let filteredPerson = personsArr.filter( function(val) { //callback function
            if(val.id == req.params.id) { //filtering criteria
                return val;
            }
        })
        res.send(filteredPerson);
    }
    catch (error) {
        res.send(error.toString('ascii'));
    }
});

app.post('/persons', async (req, res) => {
    try {
        const {id,name,email,gender,age} = req.body;
        if(id==null || name==null || gender==null || age==null || email==null) throw 'you must provide all attributes (id, name, email, gender,age)'
        const newPerson ={
            id: id,
            name: name,
            email: email,
            gender: gender,
            age:age
        }
        index=personsArr.findIndex((obj=> obj.id ==newPerson.id))
        if(index!=-1) throw 'There is a person with same id'
        personsArr.push(newPerson)
        write()
        res.send("New Person added Successfuly");
    }
    catch (error) {
        res.status(500).send(error.toString('ascii'));
    }
});

app.put('/persons/:id', async (req, res) => {
    try {
        const newId = req.body["id"];
        const newName = req.body["name"];
        const newEmail = req.body["email"];
        const newGender = req.body["gender"];
        const newAge = req.body["age"];
        index=personsArr.findIndex((obj=>obj.id==req.params.id));
        index2=personsArr.findIndex((obj=>obj.id==newId));
        if(index==-1) throw 'id not found'
        if(index2 !=-1 && index!=index2) throw 'new id already exists'
        if(newId) personsArr[index].id=newId;
        if(newName) personsArr[index].name=newName;
        if(newEmail) personsArr[index].email=newEmail;
        if(newGender) personsArr[index].gender=newGender;
        if(newAge) personsArr[index].age=newAge;
        write()
        console.log("Updated Successfuly")
        res.send('Update complete')
    }
    catch (error) {
        res.send(error.toString('ascii'));
    }
});


app.delete('/persons/:id', async (req, res) => {    //http://localhost:5000/products/1
    try {
        index=personsArr.findIndex((obj=>obj.id==req.params.id))
        if(index==-1)throw 'no person with this id'
        let filteredPersons = personsArr.filter( function(val) { //callback function
            if(val.id != req.params.id) { //filtering criteria
                return val;
            }
        })
        personsArr=filteredPersons
        write()
        res.send('Deleted Successfuly');
    }
    catch (error) {
        res.send(error.toString('ascii'));
    }
});





function arrayToString(array) {
    var str='';
    for(var i=0;i<array.length;i++){
        str+=toString(array[i]);
    }
    return str;
}

function toString(data){
    return data.id + '\n' + data.name + '\n' + data.email + '\n' + data.gender + '\n' + data.age + '\n';
}

function write(){
    fs.writeFile(dataFile, arrayToString(personsArr), (err) => {
    if (err) throw err;
    else{
        console.log("The file is updated with the given data")
        }
    })
}

function read(){
    const ReadLines = require('n-readlines');
    const readLines = new ReadLines(dataFile);
    let line;
    while ((line = readLines.next())) {
        var person={
            id :line.toString('ascii'),
            name :line=readLines.next().toString('ascii'),
            email :line=readLines.next().toString('ascii'),
            gender : line=readLines.next().toString('ascii'),
            age :line=readLines.next().toString('ascii')
        };
        personsArr.push(person)
    }
}