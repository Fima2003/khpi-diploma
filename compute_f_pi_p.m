function f_pi_p = compute_f_pi_p(p, tau, c, T, A, beta_td, theta)

    % Compute the first term: -tau^-1 * [c' * T^-1 * A * p + beta]
    term1 = -inv(tau) * (c' * (T \ A) * p + beta_td);

    % Compute the second term: -(theta * tau)^-1 * (p' * c * T)
    term2 = -inv(theta * tau) * (c'*p);

    % Sum the terms
    f_pi_p = term1 + term2;
end