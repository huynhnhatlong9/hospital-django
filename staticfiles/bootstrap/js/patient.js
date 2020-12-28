function validate(data) {
    let check=true
    $.each(data, function (i, item) {
        if (item == ""||(typeof(item)=="number"&& isNaN(item))){
            check=false
            toastr.error('Vui lòng điền đầy đủ thông tin!');
            return false;
        }
    })
    return check
}

// Yeu cau 1
$('#modal-capnhatnhankhau #submit').on('click', function (event) {
    data = {
        ho: $('#modal-capnhatnhankhau #ho').val(),
        ten: $('#modal-capnhatnhankhau #ten').val(),
        tuoi: parseInt($('#modal-capnhatnhankhau #tuoi').val()),
        dantoc: $('#modal-capnhatnhankhau #dantoc').val(),
        nghenghiep: $('#modal-capnhatnhankhau #nghenghiep').val(),
    };
    console.log(data);
    let check = validate(data)
    console.log(check)
    if (check) {
        $.ajax({
                url: "",
                type: 'post',
                headers: {
                    "X-CSRFToken": token
                },
                data: {
                    data: JSON.stringify(data),
                    type: 'capnhatnhankhau'
                },
                success: function (response) {
                    toastr.success("Cập nhật thành công !");
                    $('#modal-capnhatnhankhau').modal('hide')
                },
                error: function (data) {
                    toastr.error(data.responseJSON.error);
                    // alert(data.responseJSON.error);
                }
            },
        );
    }

});

// Yeu cau 1
$('#modal-capnhatbaohiem #submit').on('click', function (event) {
    data = {
        mathe: $('#modal-capnhatbaohiem #mathe').val(),
        thoihan: $('#modal-capnhatbaohiem #tgdk').val(),
        noidangki: $('#modal-capnhatbaohiem #noidangki').val(),
    };
    let check = validate(data)
    if (check) {
        $.ajax({
                url: "",
                type: 'post',
                headers: {
                    "X-CSRFToken": token
                },
                data: {
                    data: JSON.stringify(data),
                    type: 'capnhatbaohiem'
                },
                success: function (response) {
                    toastr.success("Cập nhật thành công !");
                    $('#modal-capnhatbaohiem').modal('hide')
                },
                error: function (data) {
                    toastr.error(data.responseJSON.error);
                    // alert(data.responseJSON.error);
                }
            },
        );
    }

});
