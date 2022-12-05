# Contains various membership function types
# ------------------------------------------

"""	 Membership function type
"""
abstract type MF end


"""	 Triangular membership function type

    TriangularMF(l_vertex, center, r_vertex)

    Properties
    ----------
    `l_vertex`, `center` and `r_vertex` are the vertices of the triangle, in order
"""
mutable struct TriangularMF{L<:Real,C<:Real,R<:Real} <: MF
    l_vertex::L
    center::C
    r_vertex::R

    function TriangularMF{L,C,R}(l_vertex::L, center::C, r_vertex::R) where {L<:Real, C<:Real, R<:Real}
        if l_vertex <= center <= r_vertex
            new(l_vertex, center, r_vertex)
        else
            error("invalid vertices")
        end
    end
end
TriangularMF(l_vertex::L, center::C, r_vertex::R) where {L<:Real, C<:Real, R<:Real} = TriangularMF{L,C,R}(l_vertex, center, r_vertex)


"""
Gaussian membership function type

    GaussianMF(center, sigma)

    Properties
    ----------
    `center` is the center of the distribution
    `sigma` determines width of the distribution

"""
mutable struct GaussianMF{C<:Real,S<:Real} <: MF
    center::C
    sigma::S

    function GaussianMF{C,S}(center, sigma) where {C<:Real, S<:Real}
        new(center, sigma)
    end
end
GaussianMF(center::C, sigma::S) where {C<:Real, S<:Real} = GaussianMF{C,S}(center, sigma)

"""
    Generalised Bell membership function type

    BellMF(a, b, c)

    Properties
    ----------
    `a`, `b` and `c` the usual bell parameters with `c` being the center

"""
mutable struct BellMF{A<:Real, B<:Real, C<:Real} <: MF
    a::A
    b::B
    c::C

    function BellMF{A,B,C}(a::A, b::B, c::C) where {A<:Real, B<:Real, C<:Real}
        new(a, b, c)
    end
end
BellMF(a::A, b::B, c::C) where {A<:Real, B<:Real, C<:Real} = BellMF{A,B,C}(a, b, c)


"""
    Trapezoidal membership function type

    TrapezoidalMF(l_bottom_vertex, l_top_vertex, r_top_vertex, r_bottom_vertex)

    Properties
    ----------
    `l_bottom_vertex`, `l_top_vertex`, `r_top_vertex` and `r_bottom_vertex` are the vertices of the trapezoid, in order
"""
mutable struct TrapezoidalMF{LB<:Real,LT<:Real,RT<:Real,RB<:Real} <: MF
    l_bottom_vertex::LB
    l_top_vertex::LT
    r_top_vertex::RT
    r_bottom_vertex::RB

    function TrapezoidalMF{LB,LT,RT,RB}(l_bottom_vertex::LB, l_top_vertex::LT, r_top_vertex::RT, r_bottom_vertex::RB) where {LB<:Real,LT<:Real,RT<:Real,RB<:Real}
        if l_bottom_vertex <= l_top_vertex <= r_top_vertex <= r_bottom_vertex
            new(l_bottom_vertex, l_top_vertex, r_top_vertex, r_bottom_vertex)
        else
            error("invalid vertices")
        end
    end
end
TrapezoidalMF(l_bottom_vertex::LB, l_top_vertex::LT, r_top_vertex::RT, r_bottom_vertex::RB) where {LB<:Real,LT<:Real,RT<:Real,RB<:Real} = TrapezoidalMF{LB,LT,RT,RB}(l_bottom_vertex, l_top_vertex, r_top_vertex, r_bottom_vertex)

"""
    Sigmoid membership function type

    SigmoidMF(a, c, limit)

    Properties
    ----------
    `a` controls slope
    `c` is the crossover point
    `limit` sets the extreme limit
"""
mutable struct SigmoidMF{A<:Real,C<:Real,L<:Real} <: MF
    a::A
    c::C
    limit::L

    function SigmoidMF{A,C,L}(a::A, c::C, limit::L) where {A<:Real, C<:Real, L<:Real}
        if (a > 0 && limit > c) || (a < 0 && limit < c)
            new(a, c, limit)
        else
            error("invalid parameters")
        end
    end
end
SigmoidMF(a::A, c::C, limit::L) where {A<:Real, C<:Real, L<:Real} = SigmoidMF{A,C,L}(a, c, limit)
