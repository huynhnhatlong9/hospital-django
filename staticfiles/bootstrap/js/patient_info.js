ngaykham = $('#ngaykham')
ngaykham.change(function (e) {
    $.ajax({
        url: "",
        type: 'post',
        data: {
            type: "date_filter",
            data: JSON.stringify({'date': ngaykham.val()})
        },
        success: function (response) {
            let data = response.data
            let each_child = ''
            for (i = 0; i < data.length; i++) {
                each_child += '<tr>' + '<td>' + data[i][7] + '</td>' +
                    '<td>' + data[i][0] + '</td>' +
                    '<td>' + data[i][1] + data[i][2] + '</td>' +
                    '<td>' + data[i][3] + '</td>' +
                    '<td>' + data[i][11] + '</td>' +
                    '<td><a href="' + Urls['patient_info_with_id'](`${data[i][0]}/${data[i][7]}`) + '"><button class="btn btn-success">Xem</button></a></td>' +
                    '</tr>'
            }
            $('#listbenhnhan').html(each_child)
        },
        error: function (data) {
            toastr.error(data.responseJSON.error);
        }

    })
})