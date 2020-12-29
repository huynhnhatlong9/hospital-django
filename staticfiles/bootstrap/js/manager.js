$('#modal-bacsi #submit').on('click', function (e) {
        data = {
            ngay: $('#modal-bacsi #ngay').val(),
            ca: $('#modal-bacsi #ca').val(),
            khoa: $('#modal-bacsi #khoa').val()
        }
        let check = true
        if (check) {
            $.ajax({
                    url: "",
                    type: 'post',
                    data: {
                        data: JSON.stringify(data),
                        type: 'thongkebacsi'
                    },
                    success: function (response) {
                        let innerContent = ""
                        for (i of response.data) {
                            innerContent += (`<tr>
                        <td scope="row">${i[0]}</td>
                        <td scope="row">${i[1]}</td>
                        <td scope="row">${i[2]}</td>
                        <td scope="row">${i[3]}</td>
                    </tr>`)
                        }
                        $('#modal-thongkebacsi .modal-body').html("");
                        $('#modal-thongkebacsi .modal-body').html(`
                <table class="table table-{1:striped|sm|bordered|hover|inverse} table-inverse table-bordered">
                <thead class="thead-inverse|thead-default table-bordered table-primary">
                <tr>
                    <th>Mã Bác Sĩ</th>
                    <th>Tên</th>
                    <th>Chuyên Khoa</th>
                    <th>Năm Kinh Nghiệm</th>
                </tr>
                </thead>
                <tbody>
                ${innerContent}
                </tbody>
                </table>
                `)
                        $('#modal-bacsi').modal('hide');
                        $('#modal-thongkebacsi').modal()
                    },
                    error: function (data) {
                        toastr.error(data.responseJSON.error);
                    }
                },
            );
        }
    }
)

$('#modal-benhnhan #submit').on('click', function (e) {
    data = {
        ngay: $('#modal-benhnhan #ngay').val(),
        ca: $('#modal-benhnhan #ca').val(),
        khoa: $('#modal-benhnhan #khoa').val(),
        noingoai: $('#modal-benhnhan #noingoai').val()
    };
    let check = true
    if (check) {
        $.ajax({
                url: "",
                type: 'post',
                data: {
                    data: JSON.stringify(data),
                    type: 'thongkebenhnhan'
                },
                success: function (response) {
                    let innerContent = ""
                    for (i of response.data) {
                        innerContent += (`<tr>
                        <td scope="row">${i[0]}</td>
                        <td scope="row">${i[1]}</td>
                        <td scope="row">${i[2]}</td>
                        <td scope="row">${i[3]}</td>
                        <td scope="row">${i[4]} ${i[5]} </td>
                    </tr>`)
                    }
                    $('#modal-thongkebenhnhan .modal-body').html("");
                    $('#modal-thongkebenhnhan .modal-body').html(`
                <table class="table table-{1:striped|sm|bordered|hover|inverse} table-inverse table-bordered">
                <thead class="thead-inverse|thead-default table-bordered table-primary">
                <tr>
                    <th>Mã Khám</th>
                    <th>Ca Khám</th>
                    <th>Thời Gian Khám</th>
                    <th>Mã Bệnh Nhân</th>
                    <th>Tên</th>
                </tr>
                </thead>
                <tbody>
                ${innerContent}
                </tbody>
                </table>
                `)
                    $('#modal-benhnhan').modal('hide');
                    $('#modal-thongkebenhnhan').modal()
                },
                error: function (data) {
                    toastr.error(data.responseJSON.error);
                }
            },
        );
    }
})




$('#modal-xetnghiem #submit').on('click', function (e) {
    data = {
        ngay: $('#modal-xetnghiem #ngay').val(),
        khoa: $('#modal-xetnghiem #khoa').val(),
    };
    let check = true
    if (check) {
        $.ajax({
                url: "",
                type: 'post',
                data: {
                    data: JSON.stringify(data),
                    type: 'thongkexetnghiem'
                },
                success: function (response) {
                    let innerContent = ""
                    for (i of response.data) {
                        innerContent += (`<tr>
                        <td scope="row">${i[0]}</td>
                        <td scope="row">${i[1]}</td>
                        <td scope="row">${i[2]}</td>
                    </tr>`)
                    }
                    $('#modal-thongkexetnghiem .modal-body').html("");
                    $('#modal-thongkexetnghiem .modal-body').html(`
                <table class="table table-{1:striped|sm|bordered|hover|inverse} table-inverse table-bordered">
                <thead class="thead-inverse|thead-default table-bordered table-primary">
                <tr>
                    <th>Mã Xét Nghiệm</th>
                    <th>Tên Khoa</th>
                    <th>Thời Gian Xét Nghiệm</th>
                </tr>
                </thead>
                <tbody>
                ${innerContent}
                </tbody>
                </table>
                `)
                    $('#modal-xetnghiem').modal('hide');
                    $('#modal-thongkexetnghiem').modal()
                },
                error: function (data) {
                    toastr.error(data.responseJSON.error);
                }
            },
        );
    }
})

