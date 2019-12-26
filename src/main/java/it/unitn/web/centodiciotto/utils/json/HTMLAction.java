package it.unitn.web.centodiciotto.utils.json;

/**
 * HTML HTMLAction wrapper, used to represent a button that may or may not enabled with a specific label.
 */
public class HTMLAction {
    private String label;
    private Boolean enable;

    /**
     * Instantiates a new HTMLAction.
     *
     * @param label  the label
     * @param enable true if the button must be initialized as enabled
     */
    public HTMLAction(String label, Boolean enable) {
        this.label = label;
        this.enable = enable;
    }
}
