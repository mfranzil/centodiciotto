package it.unitn.web.centodiciotto.utils.entities;

import java.util.Objects;

/**
 * Simple class that mimics a JavaFX pair and allows coupling of two {@link Object}s of an arbitrary type.
 *
 * @param <F> first item
 * @param <S> second item
 */
public class Pair<F, S> {
    private final F first;
    private final S second;

    /**
     * Instantiates a new Pair.
     *
     * @param first  the first item
     * @param second the second item
     */
    public Pair(F first, S second) {
        this.first = first;
        this.second = second;
    }

    /**
     * Make pair pair.
     *
     * @param <A> the first item's type
     * @param <B> the second item's type
     * @param a   the first item
     * @param b   the second item
     * @return the pair
     */
    public static <A, B> Pair<A, B> makePair(A a, B b) {
        return new Pair<>(a, b);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Pair<?, ?> p)) {
            return false;
        }
        return Objects.equals(p.first, first) && Objects.equals(p.second, second);
    }

    @Override
    public int hashCode() {
        return (first == null ? 0 : first.hashCode()) ^ (second == null ? 0 : second.hashCode());
    }

    /**
     * Gets the first item.
     *
     * @return the first item
     */
    public F getFirst() {
        return first;
    }

    /**
     * Gets the second item.
     *
     * @return the second item
     */
    public S getSecond() {
        return second;
    }
}