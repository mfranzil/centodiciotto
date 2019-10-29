function getDetails(patientID) {
    let popup_window = document.createElement("div");
    popup_window.id = "popup";
    popup_window.style.display = "none";
    $.ajax({
        type: "POST",
        dataType: "json",
        data: {
            request_type: "detailed_info",
            patient: patientID
        },
        url: getContextPath() + "/restricted/general_practitioner/patient_list",
        success: function (json) {
            console.log(json);
            popup_window.className = "popup-window";

            let popup_animate = document.createElement("div");
            popup_animate.classList.add("popup");
            popup_animate.classList.add("animate-in");

            let inner_popup = document.createElement("div");

            let text = document.createElement("p");
            text.textContent = "speriamo che vada";

            inner_popup.appendChild(text);
            popup_animate.appendChild(inner_popup);
            popup_window.appendChild(popup_animate);
        }
    });
    return popup_window;
}

$("document").ready(function () {

    $.fn.createTableHeaders = function (headers) {
        this.html("");
        let headersDiv = document.createElement("div");
        headersDiv.classList.add("table-personal");
        headersDiv.classList.add("table-header");

        $.each(headers, function (index, header) {
            let headerDiv = document.createElement("div");
            headerDiv.className = "table-cell " + header.field;
            headerDiv.innerHTML = header.text;
            headersDiv.appendChild(headerDiv);
        });
        this.append(headersDiv);

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
                            button.classList.add("btn");
                            button.classList.add("btn-block");
                            button.classList.add("btn-personal");
                            button.classList.add("popup-opener");
                            button.innerHTML = item[header.field];
                            button.onclick = function(){
                                $("#popup").remove();
                                cell.appendChild(getDetails(item.ID));
                                enablePopup();
                            };

                            cell.appendChild(button);
                            enablePopup();
                            break;
                        }
                        default: {
                        }
                    }

                }
                row.appendChild(cell);
                enablePopup();
            });
            main_table.append(row);
            enablePopup();
        });
        enablePopup();
        return this;

    };
});