function comparar_modelos_interactivos
    % Parámetros base
    r = 1.2;        % año⁻¹
    K = 300;        % capacidad de carga
    alpha = 0.061;  % gato⁻¹·año⁻¹
    z = 1;          % número de gatos
    T = 5;          % tiempo total en años
    dt = 0.01;

    % Equilibrio y Jacobiano
    x_star = K * (1 - alpha * z / r);
    A = r * (1 - 2 * x_star / K) - alpha * z;

    % Crear figura
    f = figure('Name','Modelo No Lineal vs Lineal','Position',[100 100 800 500]);
    
    % Slider para desviación inicial
    uicontrol('Style','text','String','Desviación inicial Δx','Units','normalized',...
              'Position',[0.2 0.05 0.2 0.04],'FontWeight','bold');
    sld = uicontrol('Style','slider','Min',1,'Max',150,'Value',10,...
              'Units','normalized','Position',[0.4 0.05 0.4 0.04],...
              'Callback',@updatePlot);

    ax = axes('Parent',f,'Position',[0.1 0.15 0.85 0.8]);
    grid on; hold on;
    xlabel('Tiempo [años]');
    ylabel('Población de chochines');
    title('Comparación Modelo No Lineal vs Lineal (z = 1 gato)');
    legend('show');

    updatePlot();

    function updatePlot(~,~)
        cla(ax);  % limpiar ejes
        dx = sld.Value;
        x0 = x_star + dx;
        t = 0:dt:T;

        % Modelo No Lineal
        x_nl = zeros(size(t));
        x_nl(1) = x0;
        for k = 1:length(t)-1
            x_nl(k+1) = x_nl(k) + dt * (r * x_nl(k) * (1 - x_nl(k)/K) - alpha * z * x_nl(k));
            x_nl(k+1) = max(x_nl(k+1), 0);
        end

        % Modelo Lineal (LTI)
        x_D0 = x0 - x_star;
        x_lin = x_D0 * exp(A * t) + x_star;

        % Graficar
        plot(ax, t, x_nl, 'r-', 'LineWidth', 2, 'DisplayName', 'No Lineal');
        plot(ax, t, x_lin, 'b--', 'LineWidth', 2, 'DisplayName', 'Lineal');
        legend(ax, 'Location', 'northeast');
        ylim(ax, [0 max([x0 400])]);
    end
end
