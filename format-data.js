var fileInput = process.argv[2] || "test-data.json";
var fileOutput = process.argv[3] || "output-data.json";

var fs = require("fs");

var sep = "";

var lineReader = require('readline').createInterface({
    input: fs.createReadStream(fileInput)
});

console.log("Start formating data to proper json...");
console.log(" -> Input file:", fileInput);
console.log(" -> Output file:", fileOutput);

lineReader.on("line", function (line) {
    var obj = JSON.parse(line);
    var cleaned = {};

    for (var prop in obj) {
        if (obj[prop].hasOwnProperty("n")) {
            cleaned[prop] = parseInt(obj[prop]["n"], 10);
        } else if (obj[prop].hasOwnProperty("s")) {
            cleaned[prop] = obj[prop]["s"];
        } else {
            console.log("Not handled type! " + cleaned[prop]);
        }
    }

    fs.appendFile(fileOutput, sep + JSON.stringify(cleaned), function (err) {
        if (err) throw err;
    });

    if (!sep) sep = ",\n";
}).on("close", function() {
    console.log("Formating data done!");
    process.exit(0);
});
