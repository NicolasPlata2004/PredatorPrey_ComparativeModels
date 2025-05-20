function comparar_modelos_interactivos
    % Parámetros fijos
    r = 1.2;        % año⁻¹
    K = 300;        % capacidad de carga
    alpha = 0.061;  % gato⁻¹·año⁻¹
    T = 5;          % tiempo total
    dt = 0.01;

    % Crear figura
    f = figure('Name','Modelo No Lineal vs Lineal','Position',[100 100 800 600]);
    
    % Slider para desviación inicial (dx)
    uicontrol('Style','text','String','Desviación inicial Δx','Units','normalized',...
              'Position',[0.15 0.05 0.2 0.04],'FontWeight','bold');
    sld_dx = uicontrol('Style','slider','Min',1,'Max',150,'Value',10,...
              'Units','normalized','Position',[0.35 0.05 0.5 0.04],...
              'Callback',@updatePlot);

    % Slider para número de gatos (z)
    uicontrol('Style','text','String','Número de gatos z','Units','normalized',...
              'Position',[0.15 0.00 0.2 0.04],'FontWeight','bold');
    sld_z = uicontrol('Style','slider','Min',0.5,'Max',10,'Value',1,...
              'SliderStep',[0.1 0.2],'Units','normalized','Position',[0.35 0.00 0.5 0.04],...
              'Callback',@updatePlot);

    % Ejes
    ax = axes('Parent',f,'Position',[0.1 0.15 0.85 0.8]);
    grid on; hold on;
    xlabel('Tiempo [años]');
    ylabel('Población de chochines');
    title('Comparación Modelo No Lineal vs Lineal');
    legend('show');

    updatePlot();

    function updatePlot(~,~)
        cla(ax);
        dx = sld_dx.Value;
        z = sld_z.Value;

        % Recalcular equilibrio y Jacobiano
        x_star = K * (1 - alpha * z / r);
        A = r * (1 - 2 * x_star / K) - alpha * z;
        x0 = x_star + dx;

        % Tiempo y arreglos
        t = 0:dt:T;
        x_nl = zeros(size(t));
        x_nl(1) = x0;

        % Modelo no lineal
        for k = 1:length(t)-1
            dx_nl = r * x_nl(k) * (1 - x_nl(k)/K) - alpha * z * x_nl(k);
            x_nl(k+1) = max(x_nl(k) + dt * dx_nl, 0);
        end

        % Modelo linealizado
        x_D0 = x0 - x_star;
        x_lin = x_D0 * exp(A * t) + x_star;

        % Graficar
        plot(ax, t, x_nl, 'r-', 'LineWidth', 2, 'DisplayName', 'No Lineal');
        plot(ax, t, x_lin, 'b--', 'LineWidth', 2, 'DisplayName', 'Lineal');
        legend(ax, 'Location', 'northeast');
        ylim(ax, [0 max([x0 400])]);
    end
end
