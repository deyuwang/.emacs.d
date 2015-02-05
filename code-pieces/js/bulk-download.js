var fs = require('fs');
var file = "d:\\openstack_questions.org";

function appendToFile(str){
	fs.appendFile(file, str, function (err) {
		if (err) throw err;
		console.log('It\'s saved!');
	});
}


function loadJQuery(callback){
	var s = document.createElement('script');
	s.src = 'http://code.jquery.com/jquery-1.9.0.js';
	var b = document.getElementsByTagName('body')[0];
	b.appendChild(s);
	s.onload = callback;
}

function getPage(path, f){
    return $.ajax({
        url: path,
        type: "get",
        dataType: "html",
        data: "",
        success: f
    });
}

function parse(data){
	try{
		var html = $(data);
		var links = html.find('h2').find('a');
		
		$.each(links, function(i, e){
			console.log(e.innerHTML);
			console.log(e.href);
		});
	}catch(e){
	}
}

function getPages(start, end){
	try{
		for(var i=start; i<=end; i++){
			var url = "https://ask.openstack.org/en/questions/scope:all/sort:activity-desc/page:" + i + "/";
			getPage(url, parse);
		}
	}catch(e){
		console.log('Error and exit:');
		console.log(e);
	}
}


function start(){
	getPage("https://ask.openstack.org/en/questions/", parse);
	//getPages(2, 4);
}

start();
