// $('#submit1').on('click', function (e) {
//     var data = {
//         makham: $('#yeucau1 #makham').val()
//
//     }
//     console.log(data)
// })
//
//
// // Yeu cau 2
//
// $('#submit2').on('click', function (event) {
//     $.ajax({
//         url: "",
//         type: 'post',
//         headers: {
//             "X-CSRFToken": token
//         },
//         data: {
//             type: "BS2"
//         },
//         success: function (response) {
//
//         },
//         error: function (data) {
//             toastr.error(data.responseJSON.error);
//             // alert(data.responseJSON.error);
//         }
//
//     })
//
// });
// //Yeu cau 3
// $('#submit3-1').on('click', function (e) {
//     ngaykham = $('#yeucau3-1 #ngaykham')
//     if (ngaykham.val() == '') {
//
//     } else {
//         modal_show = $('#yeucau3-2')
//         modal_content_wrapper = document.getElementById("modal-show3-2")
//         modal_content_wrapper.innerHTML=''
//         $('#yeucau3-1').modal('hide')
//         $.ajax({
//             url: "",
//             type: 'post',
//             headers: {
//                 "X-CSRFToken": token
//             },
//             data: {
//                 type: "BS3",
//                 info: JSON.stringify({ngaykham: ngaykham.val()})
//             },
//             success: function (response) {
//                 data = response.data
//                 modal_content = document.createElement('div')
//                 each_child = ''
//                 for (i = 0; i < data.length; i++) {
//                     each_child += '<tr>' + '<td>' + data[i][0] + '</td>' +
//                         '<td>' + data[i][1] + data[i][2] + '</td>' +
//                         '<td>' + data[i][3] + '</td>' +
//                         '<td>' + data[i][4] + '</td>' +
//                         '<td>' + data[i][5] + '</td>' + '</tr>'
//                 }
//                 var innerHTML = '<table class="table table-{1:striped|sm|bordered|hover|inverse} table-inverse table-bordered">\n' +
//                     '            <thead class="thead-inverse|thead-default table-bordered table-success">\n' +
//                     '            <tr>\n' +
//                     '                <th>Mã bệnh nhân</th>\n' +
//                     '                <th>Tên</th>\n' +
//                     '                <th>Tuổi</th>\n' +
//                     '                <th>Dân tộc</th>\n' +
//                     '                <th>Nghề nghiệp</th>\n' +
//                     '            </tr>\n' +
//                     '            </thead>\n' +
//                     '            <tbody>\n' + each_child +
//                     '</tbody>\n' +
//                     '        </table>';
//
//                 modal_content.innerHTML = innerHTML
//                 modal_content_wrapper.appendChild(modal_content)
//             },
//             error: function (data) {
//                 toastr.error(data.responseJSON.error);
//                 // alert(data.responseJSON.error);
//             }
//
//         })
//         modal_show.modal()
//     }
// })


$('#submit-dangkibenhnhan').on('click', function (e) {
    data = {
        mabenhnhan: $('#mabenhnhan').val(),
        ho: $('#ho').val(),
        ten: $('#ten').val(),
        tuoi: parseInt($('#tuoi').val()),
        dantoc: $('#dantoc').val(),
        nghenghiep: $('#nghenghiep').val(),
        mathe: $('#mathe').val(),
        thoihan: $('#thoihan').val(),
        noidangki: $('#noidangki').val(),
    };
    console.log(data)
    $.ajax({
            url: "",
            type: 'post',
            headers: {
                "X-CSRFToken": token
            },
            data: {
                data: JSON.stringify(data),
                type: 'themmoibenhnhan'
            },
            success: function (response) {
                toastr.success("Tạo Bệnh Nhân Thành Công !");
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        },
    );
});
$('#submit-thembenhnhan').on('click', function (e) {
    data = {
        makham: $('#makham').val(),
        thoigiankham: $('#thoigiankham').val(),
        cakham: $('#cakham').val(),
        mabenhnhan: $('#mabenhnhan2').val(),
        loaibenhnhan: $("input:radio[name='loaibenhnhan']:checked").val()
    }
    // data.forEach(function (e){
    //     if (e==''){
    //         toastr.error('Vui lòng điền đầy đủ thông tin!');
    //         return;
    //     }
    // })
    let check = true;
    $.each(data, function (i, item) {
        if (item == '') {
            toastr.error('Vui lòng điền đầy đủ thông tin!');
            check = false
            return false;
        }
    })
    if (check) {
        data['cakham'] = parseInt(data['cakham'][3])
        $.ajax({
            url: "",
            type: 'post',
            headers: {
                "X-CSRFToken": token
            },
            data: {
                type: "thembenhnhan",
                data: JSON.stringify(data)
            },
            success: function (response) {
                toastr.success('Thêm Thành Công!');
                $('#modal-them-benh-nhan').modal('hide')
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }

        })

    }
});
$('#submit-thembenhan').on('click', function (e) {
    data = {
        thoigiannhapvien: $('#thoigiannhapvien').val(),
        makhoa: $('#makhoa-thembenhan').val(),
        mabenhnhan: $('#mabenhnhan-thembenhan').val(),
        sogiuong: parseInt($('#sogiuong-thembenhan').val()),
        sobuong: parseInt($('#sobuong-thembenhan').val())
    }
    let check = true;
    $.each(data, function (i, item) {
        if (item == '') {
            toastr.error('Vui lòng điền đầy đủ thông tin!');
            check = false
            return false;
        }
    })
    if (check) {
        $.ajax({
            url: "",
            type: 'post',
            headers: {
                "X-CSRFToken": token
            },
            data: {
                type: "thembenhan",
                data: JSON.stringify(data)
            },
            success: function (response) {
                toastr.success('Thêm Thành Công!');
                $('#modal-thembenhan').modal('hide');
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        })
    }
})
$('#submit-themxetnghiem').on('click', function (e) {
    data = {
        maxetnghiem: $('#maxetnghiem-xn').val(),
        makham: $('#makham-xn').val(),
        thoigianxetnghiem: $('#tgxetnghiem-xn').val(),
        tenxetnghiem: $('#tenxn-xn').val(),
        nhanxet: $('#nhanxet-xn').val()
    }
    let check = true;
    $.each(data, function (i, item) {
        if (item == '') {
            toastr.error('Vui lòng điền đầy đủ thông tin!');
            check = false
            return false;
        }
    })
    if (check) {
        $.ajax({
            url: "",
            type: 'post',
            headers: {
                "X-CSRFToken": token
            },
            data: {
                type: "themxetnghiem",
                data: JSON.stringify(data)
            },
            success: function (response) {
                toastr.success('Thêm Thành Công!');
                $('#modal-thembenhan').modal('hide');
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        })
    }
})
$('#submit-chupphim').on('click', function (e) {
    data = {
        maphim: $('#maphim-phim').val(),
        thoigianchup: $('#tgchup-phim').val(),
        makham: $('#makham-phim').val(),
        loaiphim: $('#loaiphim-phim').val(),
        nhanxet: $('#nhanxet-phim').val()
    }
    let check = true;
    $.each(data, function (i, item) {
        if (item == '') {
            toastr.error('Vui lòng điền đầy đủ thông tin!');
            check = false
            return false;
        }
    })
    if (check) {
        $.ajax({
            url: "",
            type: 'post',
            headers: {
                "X-CSRFToken": token
            },
            data: {
                type: "themphim",
                data: JSON.stringify(data)
            },
            success: function (response) {
                toastr.success('Thêm Thành Công!');
                $('#modal-chupphim').modal('hide');
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        })
    }
})

function validate(data) {
    console.log("1")
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

$('#modal-themchandoan #submit').on('click', function (e) {
    data = {
        machandoan: $('#modal-themchandoan #machandoan').val(),
        mabenh: $('#modal-themchandoan #mabenh').val(),
        // makham: $('#modal-themchandoan #makham').val(),
        noidung: $('#modal-themchandoan #noidung').val(),
        ghichu: $('#modal-themchandoan #ghichu').val()
    }
    let check = validate(data)
    if (check) {
        $.ajax({
            url: "",
            type: 'post',
            data: {
                type: "themchandoan",
                data: JSON.stringify(data)
            },
            success: function (response) {
                toastr.success('Thêm Thành Công!');
                $('#modal-themchandoan').modal('hide');
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        })
    }
});
$('#modal-themthuoc #submit').on('click', function (e) {
    data = {
        machandoan: $('#modal-themthuoc #machandoan').val(),
        mabenh: $('#modal-themthuoc #mabenh').val(),
        // makham: $('#modal-themchandoan #makham').val(),
        mathuoc: $('#modal-themthuoc #mathuoc').val(),
        lieudung: $('#modal-themthuoc #lieudung').val(),
        thoihandung: $('#modal-themthuoc #thoigiandung').val()
    }
    console.log(data)
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

$('.list button').on('click', function (e) {
    makham = $(this).attr('value').split(",")[0]
    maxetnghiem = $(this).attr('value').split(",")[1]
    data = {
        makham: makham,
        maxetnghiem: maxetnghiem
    }
    let check = true;
    if (check) {
        $.ajax({
            url: "",
            type: 'post',
            data: {
                type: "xemketquaxetnghiem",
                data: JSON.stringify(data)
            },
            success: function (response) {
                let innerContent = ""
                for (i of response.data) {
                    innerContent += (`<tr>
                        <td scope="row">${i[0]}</td>
                        <td scope="row">${i[3]}</td>
                        <td scope="row">${i[4]}</td>
                        <td scope="row">${i[5]}</td>
                    </tr>`)
                }
                $('#modal-xemketqua .modal-body').html("");
                $('#modal-xemketqua .modal-body').html(`
                <table class="table table-{1:striped|sm|bordered|hover|inverse} table-inverse table-bordered">
                <thead class="thead-inverse|thead-default table-bordered table-primary">
                <tr>
                    <th>Mã Chỉ Số</th>
                    <th>Giá Trị</th>
                    <th>Kết Quả</th>
                    <th>Mã Chỉ Số XN</th>
                </tr>
                </thead>
                <tbody>
                ${innerContent}
                </tbody>
                </table>
                `)
                $('#modal-xemketqua').modal();
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        })
    }
});
$('#btn-themkqetqua').on('click', function (e) {
    $('#modal-xemketqua').modal('hide');
    $('#modal-themketqua').modal();

})
$('#modal-themketqua #submit').on('click', function (e) {
    data = {
        'machiso': $('#modal-themketqua #machiso').val(),
        'maxetnghiem': maxetnghiem,
        'makham': makham,
        'giatri': $('#modal-themketqua #giatri').val(),
        'machisoxn': $('#modal-themketqua #machisoxn').val()
    }
    let check = validate(data)
    if (check) {
        $.ajax({
            url: "",
            type: 'post',
            data: {
                type: "themketquaxetnghiem",
                data: JSON.stringify(data)
            },
            success: function (response) {
                toastr.success('Thêm Thành Công!');
                $('#modal-themketqua').modal('hide');
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        })
    }
})
$('.modal').on('hidden.bs.modal', function (e) {
    $(this).html("");
});


$('#modal-xuatvien #submit').on('click', function (e) {
    data = {
        'makhoa': $('#modal-xuatvien #makhoa').val(),
        'mabacsinhapvien': $('#modal-xuatvien #bacsinhapvien').val(),
        'mabenhnhan': $('#modal-xuatvien #mabenhnhan').val(),
        'thoigianxuatvien': $('#modal-xuatvien #thoigianxuatvien').val(),
        'tinhtrang': $('#modal-xuatvien #tinhtrangxuatvien').val(),
        'ghichu': $('#modal-xuatvien #ghichu').val()
    }
    let check = validate(data)
    if (check) {
        $.ajax({
            url: "",
            type: 'post',
            data: {
                type: "xuatvien",
                data: JSON.stringify(data)
            },
            success: function (response) {
                toastr.success('Thêm Thành Công!');
                $('#modal-themketqua').modal('hide');
            },
            error: function (data) {
                toastr.error(data.responseJSON.error);
            }
        })
    }
})



