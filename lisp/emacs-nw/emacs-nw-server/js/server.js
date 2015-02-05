var bodyParser = require('body-parser');
var express = require('express');
var app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded());

app.get('/', function (req, res) {
	res.send('ok');
});

app.post('/openfile', function(req, res){
	var filename = req.query.filename;
	res.send(filename);	
});

app.get('/content', function(req, res){
	var content = getContent();
    res.setHeader('Content-Type', 'text/html;charset=utf-8');
	res.send(''+content);	
});

app.put('/content', function(req, res){
	var content = req.body.content;
	setContent(content);
	res.send('ok');
});

app.put('/js', function(req, res){
	var js = req.body.js;
	console.log('js:' + js);
	evalJs(js);
	res.send('ok');
});

function getContent(){
	return window.document.documentElement.outerHTML;
}

function setContent(content){
	window.document.documentElement.innerHTML = content;
}

function evalJs(js){
	eval(js);
}

function getUrl(){
	return window.location.href;
}

app.listen(13678);


















/*
//var rf = require("fs");
//var watch = require("watch");

function startWatch(){
	watch.watchTree('d:\\emacstest', {interval: 10 }, function (f, curr, prev) {
		if (typeof f == "object" && prev === null && curr === null) {
			// Finished walking the tree
		} else if (prev === null) {
			// f is a new file
		} else if (curr.nlink === 0) {
			// f was removed
		} else {
			// f was changed
			console.log(f);
			console.log(typeof f);
			//if(f.indexOf('.html') != -1){
			console.log(location.href);

			if(location.href == 'file:///' + f){
				window.top.location.reload();
			}else{
				location.href = 'file:///' + f;
			}
		}
	});

}

		$(document).ready(function(){
			//var data = rf.readFileSync("D:\\emacstest\\test.html","utf-8");
			//console.log(data);
			//console.log("READ FILE SYNC END");
		});
 */
