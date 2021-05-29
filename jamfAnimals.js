const http = require('http');
const url = require('url');

const dog = {animal:'dog', details:{genus:'Canis', sound:'Bark', habitat:'Dog House', food:'Kibbles & Bits'}};
const lion = {animal:'lion', details:{genus:'Panthera', sound:'Roar', habitat:'Savannah', food:'Antelope'}};
const horse = {animal:'horse', details:{genus:'Equus', sound:'Neigh', habitat:'Farm', food:'Hay'}};

const animals = {'dog':dog, 'lion':lion, 'horse':horse};

var port = parseInt(process.argv[2]);

var server = http.createServer(function(req, res){
  var reqURLData = url.parse(req.url, true);
  var pathname = reqURLData.pathname;
  var query = reqURLData.query;
  var method = req.method;
 
  if(method != 'GET'){
	  sendError(res, 'Invalid Request');
  }
  
  if(pathname == '/api/details') {

    var animalString = query.animal;
    console.log('request received for '+animalString);
	
	var animal = animals[animalString];
	if(animal){
		sendAnimalDetails(res, animal);
	} else {
		sendError(res, 'Animal not supported');
    }
  } else {
	  sendError(res, 'Invalid Request');
  }
 
  res.end();
});

server.listen(port);

function sendError(response, errMessage){
	var error = {error:errMessage};
	response.writeHead(404, {'Content-Type':'application/json'});
	response.write(JSON.stringify(error));
}

function sendAnimalDetails(response, animal){
    response.writeHead(200, {'Content-Type':'application/json'});
    response.write(JSON.stringify(animal));
}
