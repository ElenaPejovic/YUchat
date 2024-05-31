$(document).ready(function () {
    $.ajax({
        url: 'http://localhost:5000/api/data',
        method: 'GET',
        success: function (data) {
            console.log(data);
            $('#content').html(JSON.stringify(data));
        },
        error: function (error) {
            console.error('Error fetching data:', error);
        }
    });
    const connection = new signalR.HubConnectionBuilder()
        .withUrl("http://localhost:5000/chatHub")
        .build();

    connection.on("ReceiveMessage", function (user, message) {
        const msg = $('<div></div>').text(user + ": " + message);
        $('#content').append(msg);
    });

    connection.start().then(function () {
        console.log('SignalR connected');
    }).catch(function (err) {
        return console.error(err.toString());
    });
});
