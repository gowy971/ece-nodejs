var http = require('http');
var users = require('./users.js')
http.createServer(function(req, res){
	res.writeHead(200, {content : 'application/json'});

	if(path[0] == "get"){
		users.get(11, function(user){
					var response = {
						info : "C'est le user",
						user : user
					}
			res.end(JSON.stringify(response));
		})
	} else if (path[0] == "save"){
		users.save(path[1], function(user){
			var response = {
				info : "C'est le user savded",
				user : user
			}
			res.end(JSON.stringify(response));
		})
	}else {
		
			res.end(404,  {content : 'text/plain'});
			res.end("not a good path!")
	}
}).listen(1337,'127.0.0.1');