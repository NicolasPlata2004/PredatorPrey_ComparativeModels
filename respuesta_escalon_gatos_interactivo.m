function respuesta_escalon_gatos_interactivo
    % Parámetros base
    r = 1.2;
    K = 300;
    alpha = 0.061;
    z_eq = 1;
    x_star = K * (1 - alpha * z_eq / r);
    A = r * (1 - 2 * x_star / K) - alpha * z_eq;
    B = -alpha * x_star;

    % Tiempo de simulación
    T = 5;
    dt = 0.005;
    t = 0:dt:T;

    % Crear figura
    f = figure('Name','Respuesta a un paso en z_D','Position',[100 100 800 500]);

    % Slider para z_D
    uicontrol('Style','text','String','Paso en número de gatos (z_D)','Units','normalized',...
              'Position',[0.15 0.05 0.3 0.04],'FontWeight','bold');
    sld = uicontrol('Style','slider','Min',-1,'Max',2,'Value',1,...
              'SliderStep',[0.1 0.2],'Units','normalized','Position',[0.45 0.05 0.4 0.04],...
              'Callback',@updatePlot);

    % Ejes
    ax = axes('Parent',f,'Position',[0.1 0.15 0.85 0.75]);
    grid on; hold on;
    xlabel('Tiempo [años]');
    ylabel('Población de chochines');
    title('Respuesta a un paso en número de gatos (z_D)');
    legend('show');

    updatePlot();

    function updatePlot(~,~)
        cla(ax);
        zD = sld.Value;
        z_new = z_eq + zD;

        % Recalcular no lineal
        x0 = x_star;
        x_nl = zeros(size(t));
        x_nl(1) = x0;
        for k = 1:length(t)-1
            dx = r * x_nl(k) * (1 - x_nl(k)/K) - alpha * z_new * x_nl(k);
            x_nl(k+1) = max(x_nl(k) + dt * dx, 0);
        end

        % Lineal
        x_D = (B * zD / -A) * (1 - exp(A * t));
        x_lin = x_star + x_D;

        % Graficar
        plot(ax, t, x_nl, 'LineWidth', 2, 'DisplayName', sprintf('NL (%.1f gatos)', z_new));
        plot(ax, t, x_lin, '--', 'LineWidth', 2, 'DisplayName', sprintf('LTI (%.1f gatos)', z_new));
        ylim(ax, [0 310]);
        legend(ax, 'Location', 'best');
    end
end
