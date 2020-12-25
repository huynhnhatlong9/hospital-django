// Yeu cau 1
$('#' + 'submit1').on('click', function (event) {
    data = {
        ho: $('#ho').val(),
        ten: $('#ten').val(),
        tuoi: parseInt($('#tuoi').val()),
        dantoc: $('#dantoc').val(),
        nghenghiep: $('#nghenghiep').val(),
        mathe: $('#mathe').val(),
        tgdk: $('#tgdk').val(),
        noidangki: $('#noidangki').val(),
    };
    $.ajax({
            url: "",
            type: 'post',
            headers: {
                "X-CSRFToken": token
            },
            data: {
                info: JSON.stringify(data),
                type: 'BN1'
            },
            success: function (response) {
                toastr.success("Cập nhật thành công !");
                $('#yeucau1').modal('hide')
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
                // alert(data.responseJSON.error);
            }
        },
    );
});

// Yeu cau 2
$('#submit2').on('click', function (event) {
    $.ajax({
        url: "",
        type: 'post',
        headers: {
            "X-CSRFToken": token
        },
        data: {
            type: "BN2"
        },
        success: function (response) {

        },
        error: function (data) {
            toastr.error(data.responseJSON.error);
            // alert(data.responseJSON.error);
        }
    })
});