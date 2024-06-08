function dXdt = time_decomposed_system_of_equations(t, X, tau_g_tau_d, ag, bg, ad, bd, tau, c, T, A, alpha, beta, beta_td, theta)
    % Determine the number of suppliers and consumers
    num_suppliers = length(ag);
    num_consumers = length(ad);

    % Unpack the state variables
    Pg = X(1:num_suppliers);
    Pd = X(num_suppliers + 1:num_suppliers + num_consumers);
    d_pi_t = X(num_suppliers + num_consumers + 1);
    pi_t = X(num_suppliers + num_consumers + 2);

    % Define vector p
    p = [Pg; Pd];

    % Compute f_pi_p
    f_pi_p = compute_f_pi_p(p, tau, c, T, A, beta_td, theta);

    % Differential equations for suppliers
    dPgdt = zeros(num_suppliers, 1);
    for i = 1:num_suppliers
        dPgdt(i) = 1/tau_g_tau_d(i) * (-ag(i) * Pg(i) - bg(i) + f_pi_p);
    end

    % Differential equations for consumers
    dPddt = zeros(num_consumers, 1);
    for i = 1:num_consumers
        dPddt(i) = 1/tau_g_tau_d(num_suppliers + i) * (ad(i) * Pd(i) + bd(i) - f_pi_p);
    end

    % dpi(t)
    d_dpi_dt = -alpha(1) * pi_t + beta(1) * (sum(Pg) - sum(Pd));
    % pi(t)
    d_pi_dt = d_pi_t - alpha(2) * pi_t + beta(2) * (sum(Pg) - sum(Pd));

    % Return the derivatives as a column vector
    dXdt = [dPgdt; dPddt; d_dpi_dt; d_pi_dt];
end
