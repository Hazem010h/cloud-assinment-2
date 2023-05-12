var personsArr=[];
var person1={
    id: 1,
    name: "ali",
    email: "ali@example.com",
    age: 21
};

for(var i=0;i<2;i++){
    personsArr.push(person1);
}

const fs = require('fs')
const readline = require('readline')
var dataFile='persons.txt'

fs.writeFile(dataFile, arrayToString(personsArr), (err) => {
   if (err) throw err;
   else{
      console.log("The file is updated with the given data")
   }
})

var r =readline.createInterface({
    input : fs.createReadStream(dataFile)
})
r.on('line',function(text){
    console.log(text)
})


function arrayToString(array) {
    var str='';
    for(var i=0;i<array.length;i++){
        str+=toString(array[i]);
    }
    return str;
}

function toString(data){
    return data.id + '\n' + data.name + '\n' + data.email+'\n' + data.age+'\n';
}