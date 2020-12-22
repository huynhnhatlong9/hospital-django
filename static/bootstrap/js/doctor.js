$('#submit1').on('click', function (e) {
    var data = {
        makham: $('#yeucau1 #makham').val()

    }
    console.log(data)
})


// Yeu cau 2

$('#submit2').on('click', function (event) {
    $.ajax({
        url: "",
        type: 'post',
        headers: {
            "X-CSRFToken": token
        },
        data: {
            type: "BS2"
        },
        success: function (response) {

        },
        error: function (data) {
            toastr.error(data.responseJSON.error);
            // alert(data.responseJSON.error);
        }

    })

});
//Yeu cau 3
$('#submit3-1').on('click', function (e) {
    ngaykham = $('#yeucau3-1 #ngaykham')
    if (ngaykham.val() == '') {
        toastr.error('Vui lòng chọn ngày!');
    } else {
        modal_show = $('#yeucau3-2')
        modal_content_wrapper = document.getElementById("modal-show3-2")
        modal_content_wrapper.innerHTML=''
        $('#yeucau3-1').modal('hide')
        $.ajax({
            url: "",
            type: 'post',
            headers: {
                "X-CSRFToken": token
            },
            data: {
                type: "BS3",
                info: JSON.stringify({ngaykham: ngaykham.val()})
            },
            success: function (response) {
                data = response.data
                modal_content = document.createElement('div')
                each_child = ''
                for (i = 0; i < data.length; i++) {
                    each_child += '<tr>' + '<td>' + data[i][0] + '</td>' +
                        '<td>' + data[i][1] + data[i][2] + '</td>' +
                        '<td>' + data[i][3] + '</td>' +
                        '<td>' + data[i][4] + '</td>' +
                        '<td>' + data[i][5] + '</td>' + '</tr>'
                }
                var innerHTML = '<table class="table table-{1:striped|sm|bordered|hover|inverse} table-inverse table-bordered">\n' +
                    '            <thead class="thead-inverse|thead-default table-bordered table-success">\n' +
                    '            <tr>\n' +
                    '                <th>Mã bệnh nhân</th>\n' +
                    '                <th>Tên</th>\n' +
                    '                <th>Tuổi</th>\n' +
                    '                <th>Dân tộc</th>\n' +
                    '                <th>Nghề nghiệp</th>\n' +
                    '            </tr>\n' +
                    '            </thead>\n' +
                    '            <tbody>\n' + each_child +
                    '</tbody>\n' +
                    '        </table>';

                modal_content.innerHTML = innerHTML
                modal_content_wrapper.appendChild(modal_content)
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
                // alert(data.responseJSON.error);
            }

        })
        modal_show.modal()
    }
})