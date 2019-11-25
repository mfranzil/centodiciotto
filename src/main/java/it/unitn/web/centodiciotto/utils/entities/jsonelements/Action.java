package it.unitn.web.centodiciotto.utils.entities.jsonelements;

/**
 * HTML Action wrapper, used to represent a button that may or may not enabled with a specific label.
 */
public class Action {
    private String label;
    private Boolean enable;

    /**
     * Instantiates a new Action.
     *
     * @param label  the label
     * @param enable true if the button must be initialized as enabled
     */
    public Action(String label, Boolean enable) {
        this.label = label;
        this.enable = enable;
    }
}
