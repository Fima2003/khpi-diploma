function dXdt = aggregated_system_of_equations(t, X, tau_g, a_g, b_g, tau_d, a_d, b_d, alpha, beta)
    alpha1 = alpha(1);
    alpha2 = alpha(2);

    beta1 = beta(1);
    beta2 = beta(2);
    % Unpack the state variables
    Pg = X(1);
    Pd = X(2);
    dpi = X(3);
    pi = X(4);
    
    % Differential equations
    dPgdt = -a_g*Pg - b_g + tau_g*pi;
    dPddt = a_d*Pd + b_d - tau_d*pi;
    ddpidt = -alpha1*pi + beta1*(Pg-Pd);
    dpidt = dpi - alpha2*pi + beta2*(Pg-Pd);

    % Return the derivatives as a column vector
    dXdt = [dPgdt; dPddt; ddpidt; dpidt];
end