/* global checkUrl */

// Refresh interval in milliseconds
var refreshInterval = 1000;

// Set timer to send request every N milliseconds
var tid = setInterval(checkExport, refreshInterval);
var t = 0;

/**
 * Check the status of the export: download the file when it is ready, or display the error.
 */
function checkExport() {
    var waitExport = document.getElementById('waitExport');
    fetch(checkUrl, { headers: { 'X-Requested-With': 'XMLHttpRequest' } }).then(function (response) {
        return response.json();
    }).then(function (data) {
        if (data.status == 'ok') {
            clearInterval(tid);
            window.location = data.url;
            waitExport.innerHTML = data.message + '<br/><button class="btn btn-success" onclick="window.close();return false;">Fermer</button>';
        }
        else if (data.status == 'error') {
            waitExport.innerHTML = 'Erreur - ' + data.message + '<br/><button class="btn btn-success" onclick="window.close();return false;">Fermer</button>';
            clearInterval(tid);
        }
        else if (data.status == 'wait') {
            t += 1;
            waitExport.innerHTML = data.message + ' (' + t + ' secondes)';
        }
    }).catch(function (error) {
        console.log(error);
    });
}
