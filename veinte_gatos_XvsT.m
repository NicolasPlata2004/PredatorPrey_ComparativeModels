function bloque1_constantes
    % ----------------------------
    % Parámetros del modelo
    % ----------------------------
    r = 1.2;
    K = 300;
    alpha = 0.061;
    T = 3;
    dt = 0.002;
    x0 = 250;

    % ----------------------------
    % Valores y etiquetas separadas
    % ----------------------------
    z_vals = [0, 1, 5, 20];
    etiquetas = {'Sin gatos (z=0)', '1 gato', '5 gatos', '20 gatos'};
    colores = lines(numel(z_vals));

    % ----------------------------
    % Gráfica
    % ----------------------------
    figure('Name','Efecto del número constante de gatos');
    hold on; grid on;
    xlabel('Tiempo [años]');
    ylabel('Población de chochines');
    title('Efecto del número constante de gatos');

    for i = 1:numel(z_vals)
        z = z_vals(i);
        [t, x] = simular_poblacion_constante(x0, z, r, K, alpha, T, dt);
        plot(t, x, 'LineWidth', 2, 'DisplayName', etiquetas{i}, 'Color', colores(i,:));
    end

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
