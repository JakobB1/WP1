$(document).foundation();

$.ajax('https://localhost:7179/api/v1/Izdavac',   // request url
    {
        success: function (data, status, xhr) {// success callback function
            //console.log(data);
            for(let i=0;i<data.length;i++){
                $('#podaci').append('<li>' + data[i].naziv + '</li>');
            }
    }
});

$('#dodaj').click(function(){

    let izdavac = { naziv: $('#naziv').val(), trajanje: $('#trajanje').val(), webStranica: $('#webStranica').val() };

    $.ajax('https://localhost:7179/api/v1/Izdavac', {
        type: 'POST',  // http method
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(izdavac),  // data to submit
        success: function (data, status, xhr) {
            $('#podaci').append('<li>' + $('#naziv').val() + '</li>');
        },
        error: function (jqXhr, textStatus, errorMessage) {
                alert(errorMessage);
        }
    });

    return false;
});
