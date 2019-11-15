package it.unitn.web.centodiciotto.utils.entities;

import java.util.Objects;

/**
 * The type Pair.
 *
 * @param <F> the type parameter
 * @param <S> the type parameter
 */
public class Pair<F, S> {
    private final F first;
    private final S second;

    /**
     * Instantiates a new Pair.
     *
     * @param first  the first
     * @param second the second
     */
    public Pair(F first, S second) {
        this.first = first;
        this.second = second;
    }

    /**
     * Make pair pair.
     *
     * @param <A> the type parameter
     * @param <B> the type parameter
     * @param a   the a
     * @param b   the b
     * @return the pair
     */
    public static <A, B> Pair<A, B> makePair(A a, B b) {
        return new Pair<A, B>(a, b);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Pair)) {
            return false;
        }
        Pair<?, ?> p = (Pair<?, ?>) o;
        return Objects.equals(p.first, first) && Objects.equals(p.second, second);
    }

    @Override
    public int hashCode() {
        return (first == null ? 0 : first.hashCode()) ^ (second == null ? 0 : second.hashCode());
    }

    /**
     * Gets first.
     *
     * @return the first
     */
    public F getFirst() {
        return first;
    }

    /**
     * Gets second.
     *
     * @return the second
     */
    public S getSecond() {
        return second;
    }
}