var exec = cordova.require('cordova/exec');


function checkExternalScreenAvailable(success, fail) {
     return exec(success, fail, "ExternalMoviePlayer", "checkExternalScreenAvailable", []);
}

function playLocalMovie(url, success, fail) {
     return exec(success, fail, "ExternalMoviePlayer", "playLocalMovie", [url]);
}

function setupScreenConnectionNotificationHandlers(success, fail) {
     return exec(success, fail, "PGExternalScreen", "setupScreenConnectionNotificationHandlers", []);
}


module.exports = {
     checkExternalScreenAvailable: checkExternalScreenAvailable,
     playLocalMovie: playLocalMovie,
     setupScreenConnectionNotificationHandlers: setupScreenConnectionNotificationHandlers
};