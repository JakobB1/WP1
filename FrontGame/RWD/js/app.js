$(document).foundation();

$.ajax('https://localhost:7179/api/v1/Izdavac',   // request url
    {
        success: function (data, status, xhr) {// success callback function
            console.log(data);
    }
});
