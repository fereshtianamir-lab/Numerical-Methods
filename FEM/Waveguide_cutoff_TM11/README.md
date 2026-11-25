# FEM — waveguide cutoff frequency, TM11 mode

**File:** `FEMcutoff.m` (original, unmodified)
**Method:** Finite-Element Method for the Helmholtz eigenvalue problem (∇² + k_c²)Ez = 0 with linear triangles. A Rayleigh–Ritz estimate is formed with a single unknown node.

## Idea
For TM modes, Ez = 0 on the waveguide wall. Discretizing with triangular elements gives the generalized eigenproblem

```
[C] {Ez} = k_c² [T] {Ez}
C_ij = Σ_e (PᵢPⱼ + QᵢQⱼ)/(4A_e)        (stiffness / coefficient matrix)
T_ij = Σ_e A_e (1 + δij)/12             (mass / "metric" matrix, so T_ii = A/6)
```

With only one free node (all other nodes on the wall), the problem reduces to the scalar ratio

```
k_c = √(C11 / T11),     f_c = k_c / (2π √(μ0 ε0))
```

The script sums the contributions of the elements around that node (elements 1, 2, 3, 9 and 10). The element areas are in vector `A`, in terms of the dimension `g`.

## Output
`K = 2.0812` (for g = 1).

## Notes (left as in the original)
- The last line `f_cut=1/2*pi*sqrt(u0*e0)*K` evaluates as (π/2)·√(μ0ε0)·K, which gives 1.09·10⁻⁸. The intended formula is K/(2π√(μ0ε0)), which gives **f_c ≈ 99.5 MHz for g = 1 m** (it scales as 1/g).
- In the `c11_*` lines the area factor is written as `A/4*(…)` instead of (…)/(4A), and some contributions are negative. A one-node mesh is only a rough estimate, so treat K as illustrative.
- No animation for this one: the result is a single number.
