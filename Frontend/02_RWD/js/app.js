$(document).foundation();

$.ajax('https://localhost:7184/api/v1/Smjer',   // request url
    {
        success: function (data, status, xhr) {// success callback function
            //console.log(data);
            for(let i=0;i<data.length();i++){
                $('#podaci').append('<li>' + data[i].naziv + '</li>');
            }
    }
});
