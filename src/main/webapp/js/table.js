function getDetails(patientID) {
    let content = document.createElement("div");
    $.ajax({
        type: "POST",
        dataType: "json",
        data: {
            request_type: "detailed_info",
            patient: patientID
        },
        url: getContextPath() + "/restricted/general_practitioner/patients",
        success: function (json) {
            let text = document.createElement("p");
            text.textContent = json.firstName;
            content.appendChild(text);
        }
    });
    return content;
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



                            let popup_window = document.createElement("div");
                            popup_window.style.display = "none";
                            popup_window.className = "popup-window";

                            let popup_animate = document.createElement("div");
                            popup_animate.classList.add("popup");
                            popup_animate.classList.add("animate-in");

                            //popup_animate.appendChild(getDetails(item.ID));
                            popup_window.appendChild(popup_animate);

                            button.onclick = function(){
                                if(popup_animate.childElementCount > 0){
                                    popup_animate.childNodes[0].remove();
                                }
                                popup_animate.appendChild(getDetails(item.ID));
                            };
                            cell.appendChild(button);
                            cell.appendChild(popup_window);
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