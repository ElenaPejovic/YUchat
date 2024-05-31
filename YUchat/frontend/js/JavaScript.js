$(document).ready(function () {
    // Primer AJAX poziva ka backend API-ju
    $.ajax({
        url: 'http://localhost:5000/api/data', // URL vašeg backend API-ja
        method: 'GET',
        success: function (data) {
            console.log(data);
            // Ovde možete obraditi podatke i prikazati ih na stranici
            $('#content').html(JSON.stringify(data));
        },
        error: function (error) {
            console.error('Error fetching data:', error);
        }
    });

    // SignalR konfiguracija
    const connection = new signalR.HubConnectionBuilder()
        .withUrl("http://localhost:5000/chatHub") // URL vašeg SignalR huba
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
