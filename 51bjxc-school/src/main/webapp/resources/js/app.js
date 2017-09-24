var stompClient = null;

function setConnected(connected) {
    $("#connect").prop("disabled", connected);
    $("#disconnect").prop("disabled", !connected);
    if (connected) {
        $("#conversation").show();
    }
    else {
        $("#conversation").hide();
    }
}

function connect() {
	console.log('Start Connect ');
    //var socket = new SockJS('http://112.74.129.7:8702/time-system-websocket');
	var socket = new SockJS('http://localhost:8080/bjxc-school/time-system-websocket');
	//var socket = new SockJS('http://localhost:8080/bjxc-school/time-system-websocket' + GetRandomNum(0,1000));
	//console.log('http://localhost:8080/bjxc-school/time-system-websocket' + GetRandomNum(0,1000));
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        setConnected(true);
        console.log('Connected: ' + frame);
        sessionStorage.setItem("isconnected", 1);
        stompClient.subscribe('/topic/changeRelationship', function (greeting) {
        	if(JSON.parse(greeting.body).inscode == insCode)
        	{
        		showGreeting(JSON.parse(greeting.body).content);
        	}
            
            sessionStorage.setItem("isconnected", 0);
            //sendRecordChangeMsg();
        });
        //sendRecordChangeMsg();
        
    });
}

function GetRandomNum(Min,Max)
{   
	var Range = Max - Min;   
	var Rand = Math.random();   
	return(Min + Math.round(Rand * Range)).toString();   
}   

function disconnect() {
    if (stompClient != null) {
        stompClient.disconnect();
    }
    setConnected(false);
    console.log("Disconnected");
}

function sendRecordChangeMsg() {
    stompClient.send("/app/RecordChangeMsg", {}, JSON.stringify({'name': 'RecordChangeMsg'}));
}

function showGreeting(message) {
	console.log("socket message push");
	
	layer.alert(message);
    
}

$(function () {
    $("form").on('submit', function (e) {
        e.preventDefault();
    });
    $( "#connect" ).click(function() { connect(); });
    $( "#disconnect" ).click(function() { disconnect(); });
    $( "#send" ).click(function() { sendName(); });
});

