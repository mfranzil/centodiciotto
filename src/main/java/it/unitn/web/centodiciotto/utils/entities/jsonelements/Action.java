package it.unitn.web.centodiciotto.utils.entities.jsonelements;

/**
 * The type Action.
 */
public class Action {
    private String label;
    private Boolean enable;

    /**
     * Instantiates a new Action.
     *
     * @param label  the label
     * @param enable the enable
     */
    public Action(String label, Boolean enable) {
        this.label = label;
        this.enable = enable;
    }
}
