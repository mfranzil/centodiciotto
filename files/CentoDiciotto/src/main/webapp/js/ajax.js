$("document").ready(function () {
    $("#message").click(function(){
        $.ajax({
            type: "POST",
            url : 'http://localhost:8080/CentoDiciotto_war_exploded/restricted/patient/exam_booking',
            data : {
                selected_exam : $('#exam-search').val()
            },
            dataType: "json",
            success: function(json){
                let divs = "";
                const table = $("#main_table");
                table.html("");

                $.each(json, function(index, item) {
                    $.each(item, function(index_1, item_1) {
                        console.log(item_1.id);
                        console.log(item_1.text);
                        console.log(item_1.valid);
                        divs += ' <div class="table-personal" id="table-select">\n' +
                            '                <div class="table-cell exam">' + item_1.text + ' </div>\n' +
                            '                <div class="table-cell action">\n' +
                            '                    <button type="button" ' + (item_1.valid ? '' : 'disabled') + ' class="btn btn-block btn-personal popup-opener">\n' +
                            '                        Book Now\n' +
                            '                    </button>\n' +
                            '                    <div class="popup-window">\n' +
                            '                        <div class="popup animate-in">\n' +
                            '                            <div>\n' +
                            '                                <h4>Prenota presso un medico specialista</h4>\n' +
                            '                                <p>Io </p>\n' +
                            '                            </div>\n' +
                            '                            <button class="btn btn-lg btn-block btn-secondary popup-closer">Exit</button>\n' +
                            '                        </div>\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '            </div>';
                    });
                });
                table.append(divs);
                //$('#ajaxGetUserServletResponse').text(responseJSON);
            }
        });
    });

});