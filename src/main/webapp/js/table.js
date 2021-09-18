/**
 * JS document used in pages that require dynamic JSON requests and datatable creation.
 */

/**
 * Generates a dynamic and responsive HTML tree from an Array of elements.
 *
 * Works recursively until the DOM subtree template is exhausted.
 *
 * Supports generation of any type of HTML tags, but is specifically designed to work with buttons,
 * forms, inputs, textareas, scripts, link hrefs and selects tags.
 *
 * At the end it appends the newly created element to the supplied parent.
 *
 * @param json a JSON object obtained from the servlet or a sub-object, representing a DOM subtree
 * @param parent the HTML element to attach the newly created child
 * @returns {*} the parent
 */
function buildHtmlFromJson(json, parent) {
    let lastElement;
    json.forEach(element => {
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
                if (element.elementInputAutocomplete !== undefined)
                    htmlParagraphElement.autocomplete = element.elementInputAutocomplete;
            } else if (element.elementType === "textarea") {
                if (element.elementTextAreaPlaceholder !== undefined)
                    htmlParagraphElement.placeholder = element.elementTextAreaPlaceholder;
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

/**
 * Sends an AJAX request to a servlet URL for filling up a popup.
 * @param id the item ID to send to the servlet
 * @param url the url to send a POST request
 * @returns {HTMLDivElement} the newly created DOM tree
 */
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
        success: json => {
            buildHtmlFromJson(json, content);
            $(".loading").slideUp();
        }
    });
    return content;
}

$("document").ready(() => {
    // Applies a custom css theme to select2 items
    try {
        $.fn.select2.defaults.set("theme", "bootstrap");
    } catch (TypeError) {
        console.log("Select2 not present in the page, skipping CSS load");
    }

    /**
     * Custom jQuery function for adding table headings to the document.
     *
     * Requires base.css for responsive CSS behaviour.
     *
     * Requires additional CSS classes, one for each column,
     * including the column width (for example: .table-cell.col1 {width: 20%})
     *
     * The headers parameter must be an Array of objects of the following form:
     * {field: "", -> the name (also used in the css class)
     * type: "", -> the datatype (must be one of button, string, bool or photo)
     * text: ""} -> the header text
     *
     * @param headers an Array of objects (see description)
     * @returns {$} this (for method chaining)
     */
    $.fn.createTableHeaders = function (headers) {
        this.html("");
        let headersDiv = document.createElement("div");
        headersDiv.classList.add("table-personal");
        headersDiv.classList.add("table-header");

        $.each(headers, (index, header) => {
            let headerDiv = document.createElement("div");
            headerDiv.className = "table-cell " + header.field;
            headerDiv.innerHTML = header.text;
            headersDiv.appendChild(headerDiv);
        });
        this.append(headersDiv);

        return this;
    };
    /**
     * Inserts rows into a table previously created with #createTableHeaders.
     *
     * The headers parameter must be an Array of objects of the following form:
     * {field: "", -> the name (also used in the css class)
     * type: "", -> the datatype (must be one of button, string, bool or photo)
     * text: ""} -> the header text
     *
     * @param headers the headers previously supplied.
     * @param data a JSON object contiaining the rows
     * @param url the url to send post requests to in case of popup buttons
     * @returns {$} this (for method chaining)
     */
    $.fn.insertRows = function (headers, data, url) {
        let mainTable = this;

        $.each(data, (index, item) => {
            let row = document.createElement("div");
            row.className = "table-personal";
            row.id = "table-select";
            $.each(headers, (index1, header) => {
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
                            img.src = item[header.field];
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

                            button.onclick = () => {
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
                                loadingImage.src = imageServer + "/logo_blue.svg";
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