function validate(data) {
    let check = true
    $.each(data, function (i, item) {
        if (item == "" || (typeof (item) == "number" && isNaN(item))) {
            check = false
            toastr.error('Vui lòng điền đầy đủ thông tin!');
            return false;
        }
    })
    return check
}

$('#modal-themthuoc #submit').on('click', function (e) {
    data = {
        mathuoc: $('#modal-themthuoc #mathuoc').val(),
        tenthuoc: $('#modal-themthuoc #tenthuoc').val(),
        loaithuoc: $('#modal-themthuoc #loaithuoc').val()
    }
    let check = validate(data);
    if (check) {
        $.ajax({
            url: "",
            type: 'post',
            data: {
                type: "themthuoc",
                data: JSON.stringify(data)
            },
            success: function (response) {
                toastr.success('Thêm Thành Công!');
                $('#modal-themthuoc').modal('hide');
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        })
    }
});


$('#modal-thembenh #submit').on('click', function (e) {
    data = {
        mabenh: $('#modal-thembenh #mabenh').val(),
        tenbenh: $('#modal-thembenh #tenbenh').val(),
        mota: $('#modal-thembenh #mota').val()
    }
    let check = validate(data);
    if (check) {
        $.ajax({
            url: "",
            type: 'post',
            data: {
                type: "thembenh",
                data: JSON.stringify(data)
            },
            success: function (response) {
                toastr.success('Thêm Thành Công!');
                $('#modal-thembenh').modal('hide');
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        })
    }
});


$('.btn-listbenhnhan').on('click', function (e) {
    mabenh = $(this).attr('value').split(',')[0]
    mabacsi = $(this).attr('value').split(',')[1]
    data = {
        mabenh: mabenh,
        mabacsi: mabacsi
    }
    $('#modal-listbenhnhan #tatca').prop('checked',true)
    let check = true;
    $('#modal-listbenhnhan').modal();
    if (check) {
        $.ajax({
            url: "",
            type: 'post',
            data: {
                type: "list-benhnhan-of-benh",
                data: JSON.stringify(data)
            },
            success: function (response) {
                console.log(response.data)
                let innerContent = ""
                for (i of response.data) {
                    innerContent += (`<tr>
                        <td scope="row">${i[0]}</td>
                        <td scope="row">${i[1]}</td>
                        <td scope="row">${i[2]} ${i[3]}</td>
                    </tr>`)
                }
                $('#modal-listbenhnhan .modal-body').html("");
                $('#modal-listbenhnhan .modal-body').html(`
                <table class="table table-{1:striped|sm|bordered|hover|inverse} table-inverse table-bordered">
                <thead class="thead-inverse|thead-default table-bordered table-primary">
                <tr>
                    <th>Mã Bệnh</th>
                    <th>Mã Bệnh Nhân</th>
                    <th>Tên</th>
                </tr>
                </thead>
                <tbody>
                ${innerContent}
                </tbody>
                </table>
                `)


            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        })
    }
})

$('#modal-listbenhnhan #tatca').change(function (e){
    $.ajax({
            url: "",
            type: 'post',
            data: {
                type: "list-benhnhan-of-benh",
                data: JSON.stringify(data)
            },
            success: function (response) {
                console.log(response.data)
                let innerContent = ""
                for (i of response.data) {
                    innerContent += (`<tr>
                        <td scope="row">${i[0]}</td>
                        <td scope="row">${i[1]}</td>
                        <td scope="row">${i[2]} ${i[3]}</td>
                    </tr>`)
                }
                $('#modal-listbenhnhan .modal-body').html("");
                $('#modal-listbenhnhan .modal-body').html(`
                <table class="table table-{1:striped|sm|bordered|hover|inverse} table-inverse table-bordered">
                <thead class="thead-inverse|thead-default table-bordered table-primary">
                <tr>
                    <th>Mã Bệnh</th>
                    <th>Mã Bệnh Nhân</th>
                    <th>Tên</th>
                </tr>
                </thead>
                <tbody>
                ${innerContent}
                </tbody>
                </table>
                `)


            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        })
})

$('#modal-listbenhnhan #batthuong').change(function (e){
    $.ajax({
            url: "",
            type: 'post',
            data: {
                type: "list-benhnhan-of-benh-batthuong",
                data: JSON.stringify(data)
            },
            success: function (response) {
                console.log(response.data)
                let innerContent = ""
                for (i of response.data) {
                    innerContent += (`<tr>
                        <td scope="row">${i[0]}</td>
                        <td scope="row">${i[1]}</td>
                        <td scope="row">${i[2]} ${i[3]}</td>
                    </tr>`)
                }
                $('#modal-listbenhnhan .modal-body').html("");
                $('#modal-listbenhnhan .modal-body').html(`
                <table class="table table-{1:striped|sm|bordered|hover|inverse} table-inverse table-bordered">
                <thead class="thead-inverse|thead-default table-bordered table-primary">
                <tr>
                    <th>Mã Bệnh</th>
                    <th>Mã Bệnh Nhân</th>
                    <th>Tên</th>
                </tr>
                </thead>
                <tbody>
                ${innerContent}
                </tbody>
                </table>
                `)
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        })
});

