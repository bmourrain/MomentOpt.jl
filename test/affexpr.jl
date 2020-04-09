@testset "AbstractGMPExpr" begin
    @testset "AbstractGMPExpr Types" begin

        @test MO.GMPEmptyExpr() isa MO.AbstractGMPExpressionLike

        @testset "ObjectExpr" begin
            @polyvar x y
            m = GMPModel()
            @variable m μ Meas([x])
            @variable m ν Meas([x])
            @variable m σ SymbolicMeasure([y], FullSpace(), ChebyshevBasis)
            @test_throws AssertionError MO.same_variables([μ, σ])
            @test MO.same_variables([μ, ν]) isa Nothing
            @test MO.same_vref_type([μ, σ]) isa Nothing
            @variable m f Cont([x])
            @test MO.same_variables([μ, f]) isa Nothing
            @test_throws AssertionError MO.same_vref_type([μ, f])

            oe1 = μ + ν

            @test MO.gmp_coefficients(μ) == [1]
            @test MO.gmp_coefficients(oe1) == [1, 1]
            @test MO.gmp_variables(μ) == [μ]
            @test MO.gmp_variables(oe1) == [μ, ν]

            @test !iszero(oe1)
            @test oe1[μ] == 1
            @test length(oe1) == 2
            @test collect(oe1) isa AbstractVector
            @test oe1 == oe1
            @test !(oe1 == ν + μ) #ObjectExpr do not commute

            @test variables(oe1) == [x]
            @test MO.vref_type(oe1) == MO.AbstractGMPMeasure
            @test MO.degree(oe1) == 0

        end
        @testset "MomentExpr" begin
            @polyvar x y
            m = GMPModel()
            @variable m μ Meas([x])
            @variable m ν Meas([x])
            @variable m σ Meas([x]; basis = ChebyshevBasis)

            m1 = MomentExpr(1, μ)
            @test sprint(show, m1) == "⟨1, μ⟩"
            @test MO.gmp_coefficients(m1) == [1]
            @test MO.gmp_variables(m1) == [1*μ] 
            @test !(iszero(m1))
            @test m1[μ] isa Nothing
            @test m1[1*μ] == 1
            @test length(m1) == 1
            @test collect(m1) isa AbstractVector
            @test m1 == m1
            o1 = μ
            o2 = (μ+ν)/2
            m2 = MomentExpr([0.5, 0.5], [μ, ν])
            m3 = Mom(1, o2)
            @test !(m2 == m3)
            @test sprint(show, m2) == "⟨0.5, μ⟩ + ⟨0.5, ν⟩"
            @test sprint(show, m3) == "⟨1, 0.5μ + 0.5ν⟩" 
            @test MO.momexp_by_measure(m2) == MO.momexp_by_measure(m3)
            m4 =  Mom([1, x], [o1, o2])        
            @test MO.degree(m1) == 0 
            @test MO.degree(m2) == 0
            @test MO.degree(m3) == 0
            @test MO.degree(m4) == 1

        end

    end

    @testset "AbstractGMPExpr - Arith" begin

        @testset "ObjectExpr - Arith" begin
            @polyvar x y
            m = GMPModel()
            @variable m μ Meas([x])
            @variable m ν Meas([x])
            @variable m σ Meas([x]; basis = ChebyshevBasis)
            o1 = μ
            o2 = (μ+ν)/2
            @test sum([o1, o2])+ν == 3*o2
            @test o1-μ == Mom(Int[], MO.GMPVariableRef[])
            o3 =(μ-ν)/2
            @test o2 + o3 == MO.ObjectExpr(1, o1)

        end

        @testset "MomentExpr - Arith" begin
            @polyvar x y
            m = GMPModel()
            @variable m μ Meas([x])
            @variable m ν Meas([x])
            @variable m σ Meas([x]; basis = ChebyshevBasis)
            o1 = μ
            o2 = (μ+ν)/2
            o3 =(μ-ν)/2

            m1 = MomentExpr(1.0, μ)        
            m2 = MomentExpr([0.5, 0.5], [μ, ν])
            m3 = Mom(1, o2)

            @test m1 + μ == Mom(2, μ)
            @test length(sum([m1, m2, m3])) == 3
            @test length(m3 + m1 - 2*m2) == 2
            @test MO.momexp_by_measure(Mom(1, o2) + Mom(1, o3)) == m1

        end

    end
end