/* global checkUrl */

// Refresh interval in milliseconds
var refreshInterval = 1000;

// Set timer to send request every N milliseconds
var tid = setInterval(checkExport, refreshInterval);
var t = 0;

function checkExport() {
    $.getJSON(checkUrl, function (data) {
        if (data.status == 'ok') {
            clearInterval(tid);
            window.location = data.url;
            $('#waitExport').html(data.message + '<br/><button class="btn btn-success" onclick="window.close();return false;">Fermer</button>');
        }
        else if (data.status == 'error') {
            $('#waitExport').html('Erreur - ' + data.message + '<br/><button class="btn btn-success" onclick="window.close();return false;">Fermer</button>');
            clearInterval(tid);
        }
        else if (data.status == 'wait') {
            t += 1;
            $('#waitExport').html(data.message + ' (' + t + ' secondes)');
        }
    });
}
