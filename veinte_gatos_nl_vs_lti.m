function bloque2_nl_vs_lti
    % Parámetros del modelo
    r = 1.2;
    K = 300;
    alpha = 0.061;
    T = 3;
    dt = 0.002;
    x0 = 250;         % población inicial
    z_big = 20;       % gran número de gatos

    % Calcular equilibrio x* para z = 20
    if alpha * z_big >= r
        x_star = 0;
    else
        x_star = K * (1 - alpha * z_big / r);
    end

    % Linealización alrededor de x*
    A = r * (1 - 2 * x_star / K) - alpha * z_big;
    B = -alpha * x_star;
    step = z_big - 1;  % paso con respecto al estado nominal z=1

    % Simulación no lineal
    [t_nl, x_nl] = simular_poblacion_constante(x0, z_big, r, K, alpha, T, dt);

    % Simulación linealizada
    [t_lti, x_lti] = simular_lineal(step, A, B, x_star, T, dt);

    % Gráfica
    figure('Name','NL vs LTI (20 gatos)');
    hold on; grid on;
    plot(t_nl, x_nl, 'LineWidth', 2, 'DisplayName', 'NL (z=20)');
    plot(t_lti, x_lti, '--', 'LineWidth', 2, 'DisplayName', 'LTI (linealizado en z=20)');
    xlabel('Tiempo [años]');
    ylabel('Población de chochines');
    title('Desviación grande: NL vs LTI (20 gatos)');
    legend('Location','best');
end

function [t, x] = simular_poblacion_constante(x0, z, r, K, alpha, T, dt)
    N = floor(T / dt) + 1;
    t = linspace(0, T, N);
    x = zeros(1, N);
    x(1) = x0;
    for k = 1:N-1
        dx = r * x(k) * (1 - x(k)/K) - alpha * z * x(k);
        x(k+1) = max(x(k) + dt * dx, 0);
    end
end

function [t, x] = simular_lineal(step, A, B, x_star, T, dt)
    N = floor(T / dt) + 1;
    t = linspace(0, T, N);
    x_D = (B * step / (-A)) * (1 - exp(A * t));
    x = x_star + x_D;
end
