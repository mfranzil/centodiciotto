function getPatientDetails(patientID) {
    $.ajax({
        type: "POST",
        dataType: "json",
        data: {
            request_type: "detailed_patient_info",
            patient: patientID
        },
        url: getContextPath() + "/restricted/general_practitioner/patient_list",
        success: function (json) {
            console.log(json);
        }
    });
}

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
        let main_table = this;

        $.each(data, function (index, item) {
            let row = document.createElement("div");
            row.className = "table-personal";
            row.id = "table-select";

            $.each(headers, function (index1, header) {
                let cell = document.createElement("div");
                cell.className = "table-cell " + header.field;

                if (item.hasOwnProperty(header.field)) {
                    switch (header.type) {
                        case "string": {
                            cell.innerHTML = item[header.field];
                            break;
                        }
                        case "photo" : {
                            let img = document.createElement("img");
                            img.className = "avatar-small";
                            img.src = getContextPath() + item[header.field];
                            img.alt = "Profile photo";

                            cell.appendChild(img);
                            break;
                        }
                        case "button" : {
                            let button = document.createElement("button");
                            button.type = "button";
                            button.classList.add("btn");
                            button.classList.add("btn-block");
                            button.classList.add("btn-personal");
                            button.classList.add("popup-opener");
                            button.innerHTML = item[header.field];
                            button.onclick = function(){
                                console.log(item.ID);
                                getPatientDetails(item.ID);
                            };

                            cell.appendChild(button);
                            break;
                        }
                        default: {
                        }
                    }

                }
                row.appendChild(cell);
            });
            main_table.append(row);
        });
        return this;
    };
});