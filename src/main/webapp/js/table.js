function buildHtmlFromJson(json, parent) {
    let lastElement;
    json.forEach(function (element, index) {
        if (element instanceof Array) {
            buildHtmlFromJson(element, lastElement);
        } else {
            let htmlParagraphElement = document.createElement(element.elementType);

            if (element.elementClass !== undefined) htmlParagraphElement.className = element.elementClass;
            if (element.elementStyle !== undefined) htmlParagraphElement.style = element.elementStyle;
            if (element.elementID !== undefined) htmlParagraphElement.id = element.elementID;
            if (element.elementContent !== undefined) htmlParagraphElement.innerHTML = element.elementContent;

            if (element.elementType === "button") {
                if (element.elementButtonType !== undefined) htmlParagraphElement.type = element.elementButtonType;
            } else if (element.elementType === "form") {
                if (element.elementFormAction !== undefined) htmlParagraphElement.action = element.elementFormAction;
                if (element.elementFormTarget !== undefined) htmlParagraphElement.target = element.elementFormTarget;
                if (element.elementFormMethod !== undefined) htmlParagraphElement.method = element.elementFormMethod;
            } else if (element.elementType === "input") {
                if (element.elementInputValue !== undefined) htmlParagraphElement.value = element.elementInputValue;
                if (element.elementInputType !== undefined) htmlParagraphElement.type = element.elementInputType;
                if (element.elementInputName !== undefined) htmlParagraphElement.name = element.elementInputName;
                if (element.elementInputAutocomplete !== undefined) htmlParagraphElement.autocomplete = element.elementInputAutocomplete;
            } else if (element.elementType === "textarea") {
                if (element.elementTextAreaPlaceholder !== undefined) htmlParagraphElement.placeholder = element.elementTextAreaPlaceholder;
                if (element.elementTextAreaName !== undefined) htmlParagraphElement.name = element.elementTextAreaName;
            } else if (element.elementType === "script") {
                if (element.elementScriptSrc !== undefined) htmlParagraphElement.src = element.elementScriptSrc;
                if (element.elementScriptType !== undefined) htmlParagraphElement.type = element.elementScriptType;
            } else if (element.elementType === "link") {
                if (element.elementLinkHref !== undefined) htmlParagraphElement.href = element.elementLinkHref;
                if (element.elementLinkRel !== undefined) htmlParagraphElement.rel = element.elementLinkRel;
            } else if (element.elementType === "select") {
                if (element.elementSelectName !== undefined) htmlParagraphElement.name = element.elementSelectName;
            }

            parent.appendChild(htmlParagraphElement);
            lastElement = htmlParagraphElement;
        }
    });
    return parent;
}

function getDetails(id, url) {
    let content = document.createElement("div");
    $.ajax({
        type: "POST",
        dataType: "json",
        data: {
            requestType: "detailedInfo",
            item: id
        },
        url: url,
        start: function () {

        },
        success: function (json) {
            buildHtmlFromJson(json, content);
            $(".loading").slideUp();
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

    try {
        $.fn.select2.defaults.set("theme", "bootstrap");
    } catch (TypeError) {
        console.log("Select2 not present in the page, skipping CSS load");
    }

    $.fn.insertRows = function (headers, data, url) {
        let mainTable = this;

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
                        case "bool": {
                            if (item[header.field] === true) {
                                cell.innerHTML = "Available";
                            } else {
                                cell.innerHTML = "Not available";
                            }
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
                            button.id = "btn-" + item.ID;
                            button.innerHTML = item[header.field].label;

                            if (!item[header.field].enable) {
                                button.disabled = true;
                            }

                            let popupWindow = document.createElement("div");
                            popupWindow.style.display = "none";
                            popupWindow.className = "popup-window";

                            let popupAnimate = document.createElement("div");
                            popupAnimate.classList.add("popup");
                            popupAnimate.classList.add("animate-in");

                            let exitButton = document.createElement("button");
                            exitButton.className = "btn btn-lg btn-block btn-secondary popup-closer mt-2";
                            exitButton.innerText = "Exit";

                            popupWindow.appendChild(popupAnimate);

                            button.onclick = function () {
                                while (popupAnimate.firstChild) {
                                    popupAnimate.removeChild(popupAnimate.firstChild);
                                }
                                let loading = document.createElement("div");
                                loading.classList.add("justify-content-center");
                                loading.classList.add("loading");
                                loading.classList.add("mb-2");
                                loading.style.textAlign = "center";
                                popupAnimate.append(loading);

                                let loadingImage = document.createElement("img");
                                loadingImage.classList.add("rotating");
                                loadingImage.style.width = "64px";
                                loadingImage.src = getContextPath() + "img/logo_blue.svg";
                                loadingImage.alt = "Loading";
                                loading.append(loadingImage);

                                popupAnimate.appendChild(getDetails(item.ID, url));
                                popupAnimate.appendChild(exitButton);
                                enablePopup();
                            };
                            cell.appendChild(button);
                            cell.appendChild(popupWindow);
                            break;
                        }
                        default: {
                        }
                    }
                }
                row.appendChild(cell);
            });
            mainTable.append(row);
            mainTable.append(document.createElement("hr"));
        });
        return this;
    };
});