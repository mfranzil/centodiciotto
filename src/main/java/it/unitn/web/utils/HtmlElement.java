package it.unitn.web.utils;

public class HtmlElement {
    private String elementType;
    private String elementClass;
    private String elementContent;
    private String elementID;

    private String elementButtonType;

    private String elementInputType;
    private String elementInputName;
    private String elementInputValue;

    private String elementFormAction;
    private String elementFormTarget;
    private String elementFormMethod;

    public String getElementInputType() {
        return elementInputType;
    }

    public HtmlElement setElementInputType(String elementInputType) {
        this.elementInputType = elementInputType;
        return this;
    }

    public String getElementInputName() {
        return elementInputName;
    }

    public HtmlElement setElementInputName(String elementInputName) {
        this.elementInputName = elementInputName;
        return this;
    }

    public String getElementInputValue() {
        return elementInputValue;
    }

    public HtmlElement setElementInputValue(String elementInputValue) {
        this.elementInputValue = elementInputValue;
        return this;
    }

    public String getElementType() {
        return elementType;
    }

    public HtmlElement setElementType(String elementType) {
        this.elementType = elementType;
        return this;
    }

    public String getElementClass() {
        return elementClass;
    }

    public HtmlElement setElementClass(String elementClass) {
        this.elementClass = elementClass;
        return this;
    }

    public String getElementContent() {
        return elementContent;
    }

    public HtmlElement setElementContent(String elementContent) {
        this.elementContent = elementContent;
        return this;
    }

    public String getElementID() {
        return elementID;
    }

    public HtmlElement setElementID(String elementID) {
        this.elementID = elementID;
        return this;
    }

    public String getElementButtonType() {
        return elementButtonType;
    }

    public HtmlElement setElementButtonType(String elementButtonType) {
        this.elementButtonType = elementButtonType;
        return this;
    }

    public String getElementFormAction() {
        return elementFormAction;
    }

    public HtmlElement setElementFormAction(String elementFormAction) {
        this.elementFormAction = elementFormAction;
        return this;
    }

    public String getElementFormTarget() {
        return elementFormTarget;
    }

    public HtmlElement setElementFormTarget(String elementFormTarget) {
        this.elementFormTarget = elementFormTarget;
        return this;
    }

    public String getElementFormMethod() {
        return elementFormMethod;
    }

    public HtmlElement setElementFormMethod(String elementFormMethod) {
        this.elementFormMethod = elementFormMethod;
        return this;
    }
}
