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
                        divs += ` <div class="table-personal" id="table-select">
                                            <div class="table-cell exam"> ${item_1.text}</div>
                                            <div class="table-cell action">
                                                <button type="button" ${(item_1.valid ? "" : "disabled")} class="btn btn-block btn-personal popup-opener">
                                                    Book Now
                                                </button>
                                                <div class="popup-window">
                                                    <div class="popup animate-in">
                                                        <div>
                                                            <h4>Prenota presso un medico specialista</h4>
                                                            <p>Io </p>
                                                        </div>
                                                        <button class="btn btn-lg btn-block btn-secondary popup-closer">Exit</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>`;
                    });
                });
                table.append(divs);
            }
        });
    });

});