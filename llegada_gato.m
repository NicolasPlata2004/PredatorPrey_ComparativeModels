function bloque3_escalon_dep
    % ----------------------------
    % Parámetros del modelo
    % ----------------------------
    r = 1.2;
    K = 300;
    alpha = 0.061;
    T = 3;
    dt = 0.002;
    x0 = 250;          % población inicial
    z0 = 0;            % antes del paso
    z1 = 1;            % después del paso
    t_step = 0.5;      % tiempo en el que ocurre el escalón

    % ----------------------------
    % Simulación del escalón
    % ----------------------------
    [t, x] = simular_paso_z(x0, z0, z1, t_step, r, K, alpha, T, dt);

    % ----------------------------
    % Gráfica
    % ----------------------------
    figure('Name','Respuesta a un escalón en número de gatos');
    hold on; grid on;
    plot(t, x, 'LineWidth', 2, 'DisplayName', 'NL paso 0→1 gato en 0.5 años');
    xline(t_step, 'k:', 'LineWidth', 1);
    xlabel('Tiempo [años]');
    ylabel('Población de chochines');
    title('Respuesta a un escalón de depredadores');
    legend('Location','best');
end

function [t, x] = simular_paso_z(x0, z0, z1, t_step, r, K, alpha, T, dt)
    N = floor(T / dt) + 1;
    t = linspace(0, T, N);
    x = zeros(1, N);
    x(1) = x0;
    for k = 1:N-1
        z = z0;
        if t(k) >= t_step
            z = z1;
        end
        dx = r * x(k) * (1 - x(k)/K) - alpha * z * x(k);
        x(k+1) = max(x(k) + dt * dx, 0);
    end
end
