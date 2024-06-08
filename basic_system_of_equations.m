function dXdt = basic_system_of_equations(t, X, tau_g, a_g, b_g, tau_d, a_d, b_d, alpha, beta)
    % Extract alphas and betas
    alpha1 = alpha(1);
    alpha2 = alpha(2);
    beta1 = beta(1);
    beta2 = beta(2);

    % Determine the number of suppliers and consumers
    num_suppliers = length(tau_g);
    num_consumers = length(tau_d);
    
    % Unpack the state variables
    Pg = X(1:num_suppliers);
    Pd = X(num_suppliers + 1:num_suppliers + num_consumers);
    pi = X(num_suppliers + num_consumers + 1);
    dpi = X(num_suppliers + num_consumers + 2);
    
    % Differential equations for suppliers
    dPgdt = zeros(num_suppliers, 1);
    for i = 1:num_suppliers
        dPgdt(i) = 1/tau_g(i) * (-a_g(i) * Pg(i) - b_g(i) + pi);
    end
    
    % Differential equations for consumers
    dPddt = zeros(num_consumers, 1);
    for j = 1:num_consumers
        dPddt(j) = 1/tau_d(j) * (a_d(j) * Pd(j) + b_d(j) - pi);
    end
    
    % dpi(t)
    ddpidt = -alpha1 * pi + beta1 * (sum(Pg) - sum(Pd));
    % pi(t)
    dpidt = dpi - alpha2 * pi + beta2 * (sum(Pg) - sum(Pd));
    
    % Return the derivatives as a column vector
    dXdt = [dPgdt; dPddt; dpidt; ddpidt];
end