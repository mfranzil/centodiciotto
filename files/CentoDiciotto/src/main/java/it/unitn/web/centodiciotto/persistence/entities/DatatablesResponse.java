/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 12 - Shopping List Implementation
 * UniTN
 */
package it.unitn.web.centodiciotto.persistence.entities;

import java.util.ArrayList;
import java.util.List;

/**
 * The entity that describes a Datatables response entity.
 *
 * @author Stefano Chirico &lt;stefano dot chirico at unitn dot it&gt;
 * @since 2019.05.19
 */
public class DatatablesResponse {
    private Integer draw;
    private Long recordsTotal;
    private Long recordsFiltered;
    private List<User> data;

    public DatatablesResponse(Integer draw, Long recordsTotal, Long recordsFiltered, List<User> data) {
        this.draw = draw;
        this.recordsTotal = recordsTotal;
        this.recordsFiltered = recordsFiltered;
        if (data == null) {
            data = new ArrayList<>();
        }
        this.data = data;
    }

    public DatatablesResponse() {
        this(1, 0L, 0L, null);
    }

    public Integer getDraw() {
        return draw;
    }

    public void setDraw(Integer draw) {
        this.draw = draw;
    }

    public Long getRecordsTotal() {
        return recordsTotal;
    }

    public void setRecordsTotal(Long recordsTotal) {
        this.recordsTotal = recordsTotal;
    }

    public Long getRecordsFiltered() {
        return recordsFiltered;
    }

    public void setRecordsFiltered(Long recordsFiltered) {
        this.recordsFiltered = recordsFiltered;
    }

    public List<User> getData() {
        return data;
    }

    public void setData(List<User> data) {
        this.data = data;
    }
}