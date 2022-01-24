package it.unitn.web.centodiciotto.utils;

import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;

import java.sql.Timestamp;
import java.util.Calendar;

/**
 * Enum that represents the state in which a {@link DrugPrescription} is currently in.
 * It may be any of AVAILABLE (has to be yet bought), EXPIRED (a month passed since its creation),
 * UNPAID (has been bought and the ticket awaits payment) and PAID (the ticket has been paid)
 */
public enum DrugPrescriptionState {

    AVAILABLE {
        @Override
        public String toString() {
            return "Available";
        }
    },
    EXPIRED {
        @Override
        public String toString() {
            return "Expired";
        }
    },
    UNPAID {
        @Override
        public String toString() {
            return "Ready to be paid";
        }
    },
    PAID {
        @Override
        public String toString() {
            return "Completed and paid";
        }
    };

    /**
     * Returns the state of the prescription provided.
     *
     * @param drugPrescription the prescription to check the status
     * @return a {@link DrugPrescriptionState} representing the state
     */
    public static DrugPrescriptionState getState(DrugPrescription drugPrescription) {
        if (drugPrescription.getDateSold() != null && drugPrescription.getChemistID() != null) {
            if (!drugPrescription.getTicketPaid()) {
                return UNPAID;
            } else {
                return PAID;
            }
        }

        Timestamp ts = drugPrescription.getDatePrescribed();
        Calendar cal = Calendar.getInstance();
        cal.setTime(ts);
        cal.add(Calendar.MONTH, 1);
        ts = new Timestamp(cal.getTime().getTime());

        if (ts.before(new Timestamp(System.currentTimeMillis()))) {
            return EXPIRED;
        }

        return AVAILABLE;
    }
}
