@testset "GMPModel" begin
    @testset "Model" begin
        # MO.model_info(model::GMPModel) = model.model_info
        # MO.model_data(model::GMPModel) = model.model_data
        # MO.approximation_info(model::GMPModel) = model.approximation_info
        # MO.approximation_model(model::GMPModel) = model.approximation_model
        # MO.gmp_variables(model::GMPModel) = model_data(model).variables
        # MO.gmp_constraints(model::GMPModel) = model_data(model).constraints
        # MO.variable_names(model::GMPModel) = model_info(model).variable_names
        # MO.constraint_names(model::GMPModel) = model_info(model).constraint_names
        # JuMP.object_dictionary(model::GMPModel) = model.model_info.obj_dict
        # JuMP.num_variables(model::GMPModel) = length(gmp_variables(model))
        # JuMP.termination_status(model::GMPModel)
        # JuMP.variable_type(::GMPModel)
        # 
        # JuMP.set_optimizer(model::GMPModel, optimizer::Function)
        # MO.update_degree(m::GMPModel, degree::Int)
        # set_approximation_degree(model::GMPModel, degree::Int)
        # set_approximation_mode(m::GMPModel, mode::AbstractApproximationMode) 
    end

    @testset "Objective" begin
        # JuMP.set_objective(m::GMPModel, sense::MOI.OptimizationSense, f::AbstractGMPExpressionLike)
        # JuMP.objective_sense(m::GMPModel) 
        # JuMP.set_objective_sense(m::GMPModel, sense::MOI.OptimizationSense)
        # JuMP.objective_function(m::GMPModel) 
        # JuMP.objective_function_type(m::GMPModel) 
        # JuMP.objective_function(m::GMPModel, FT::Type)
        # JuMP.objective_function_string(print_mode, m::GMPModel)
    end
    @testset "Summary" begin
        # JuMP.show_objective_function_summary(io::IO, m::GMPModel)
        # JuMP.show_backend_summary(io::IO, model::GMPModel)
    end

    @testset "Get Value" begin
        # approximation(vref::GMPVariableRef)
        # approximation(vref::GMPVariableRef, m::MP.AbstractPolynomialLike)
        # approximation(vref::GMPVariableRef, m::Number)
        # JuMP.value(me::MomentExpr)
    end

end

