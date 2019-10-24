$("document").ready(function () {
    $.fn.createTableHeaders = function (headers) {
        this.html("");
        let tableHeaders = "";
        tableHeaders += "<div class=\"table-personal table-header\">";
        $.each(headers, function (index, header) {
            tableHeaders += "<div class=\"table-cell " + header.field + "\">" + header.text + "</div>";
        });
        tableHeaders += "</div>";
        console.log(tableHeaders);

        this.append(tableHeaders);

        return this;
    };

    $.fn.insertRows = function (headers, data) {
        let tableRows = "";

        $.each(data, function (index, item) {
            console.log(item);
            tableRows += "<div class=\"table-personal\" id=\"table-select\">";

            $.each(headers, function (index1, header) {
                tableRows += "<div class=\"table-cell " + header.field + "\">";
                if (item.hasOwnProperty(header.field)) {
                    switch (header.type) {
                        case "string": {
                            tableRows += item[header.field];
                            break;
                        }
                        case "photo" : {
                            tableRows += "<img class=\"avatar-small\" src=\"" + getContextPath() + item[header.field] + "\" alt =\"Profile photo\">";
                            break;
                        }
                        case "button" : {
                            let a = "<div class=\"popup-window\">\n" +
                                "                                <div class=\"popup animate-in\">\n" +
                                "                                    <form action=\"${pageContext.request.contextPath}/restricted/general_practitioner/visits\"\n" +
                                "                                          id=\"set_visit\" method=\"POST\">\n" +
                                "                                        Insert a date and time for the appointment, then confirm.\n" +
                                "                                        <input class=\"form-control my-4\" type=\"datetime-local\" name=\"visit_date\">\n" +
                                "                                        <input type=\"hidden\" value=\"${patient.email}\" name=\"patient_email\">\n" +
                                "                                        <button class=\"btn btn-lg btn-block btn-personal\" type=\"submit\">\n" +
                                "                                            Confirm the appointment\n" +
                                "                                        </button>\n" +
                                "                                        <button class=\"btn btn-lg btn-block popup-closer btn-secondary\" type=\"button\">\n" +
                                "                                            Cancel\n" +
                                "                                        </button>\n" +
                                "                                    </form>\n" +
                                "                                </div>\n" +
                                "                            </div>";
                            tableRows += "<button type=\"button\" class=\"btn btn-block btn-personal popup-opener\">";
                            tableRows += item[header.field];
                            tableRows += "</button>";
                            tableRows += a;
                            //<div class=\"popup-window\"><div class=\"popup animate-in\"><h4>Patient data</h4></div></div>";
                            break;
                        }
                        default: {
                        }
                    }
                }
                tableRows += "</div><hr>";
            });
            tableRows += "</div>";
        });
        this.append(tableRows);

        return this;
    };
});