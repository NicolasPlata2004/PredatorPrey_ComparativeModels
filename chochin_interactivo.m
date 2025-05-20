function chochin_interactivo
% Modelo chochín–gato con sliders interactivos
% --------------------------------------------

% Parámetros fijos
K  = 300;   % capacidad de carga (aves)
x0 = 250;   % población inicial
dt = 1/365; % paso = 1 día (en años)

% Valores iniciales
r0     = 1.2;
alpha0 = 0.061;
z0     = 1;
T0     = 1.0;

% ---------- Crear figura y ejes ----------
f  = figure('Name','Modelo chochín–gato interactivo');
ax = axes('Parent',f,'Position',[0.10 0.35 0.85 0.60]);
xlabel(ax,'Tiempo [años]');
ylabel(ax,'Población de chochines');
title(ax,'Modelo chochín–gato');
grid(ax,'on');
hold(ax,'on');
ln = plot(ax,0,0,'LineWidth',2);   % línea vacía (se llenará con datos)

% ---------- Sliders (uicontrol) ----------
slider_r     = uicontrol(f,'Style','slider','Units','normalized',...
    'Min',0.05,'Max',2,'Value',r0,'Position',[0.10 0.25 0.80 0.03],...
    'Callback',@updatePlot);
text_r = uicontrol(f,'Style','text','Units','normalized',...
    'Position',[0.10 0.29 0.80 0.03],'String',sprintf('r = %.2f',r0));

slider_alpha = uicontrol(f,'Style','slider','Units','normalized',...
    'Min',0.01,'Max',300,'Value',alpha0,'Position',[0.10 0.20 0.80 0.03],...
    'Callback',@updatePlot);
text_alpha = uicontrol(f,'Style','text','Units','normalized',...
    'Position',[0.10 0.24 0.80 0.03],'String',sprintf('alpha = %.3f',alpha0));

slider_z = uicontrol(f,'Style','slider','Units','normalized',...
    'Min',0,'Max',20,'Value',z0,'SliderStep',[1/20 1/10],...
    'Position',[0.10 0.15 0.80 0.03],'Callback',@updatePlot);
text_z = uicontrol(f,'Style','text','Units','normalized',...
    'Position',[0.10 0.19 0.80 0.03],'String',sprintf('z = %d',z0));

slider_T = uicontrol(f,'Style','slider','Units','normalized',...
    'Min',0.1,'Max',5,'Value',T0,'Position',[0.10 0.10 0.80 0.03],...
    'Callback',@updatePlot);
text_T = uicontrol(f,'Style','text','Units','normalized',...
    'Position',[0.10 0.14 0.80 0.03],'String',sprintf('T = %.1f años',T0));

% ---------- Dibujar la primera curva ----------
updatePlot();

% ---------- Callback anidado ----------
function updatePlot(~,~)
    r     = slider_r.Value;
    alpha = slider_alpha.Value;
    z     = round(slider_z.Value);       % gatos como entero
    T     = slider_T.Value;

    % Actualizar etiquetas
    text_r.String     = sprintf('r = %.2f', r);
    text_alpha.String = sprintf('alpha = %.3f', alpha);
    text_z.String     = sprintf('z = %d', z);
    text_T.String     = sprintf('T = %.1f años', T);

    % Simulación numérica (Euler)
    N  = floor(T/dt) + 1;
    t  = linspace(0,T,N);
    x  = zeros(1,N);
    x(1) = x0;
    for k = 1:N-1
        dx = r * x(k) * (1 - x(k)/K) - alpha * z * x(k);
        x(k+1) = max(x(k) + dt*dx, 0);
        if x(k+1) == 0    % extinción alcanzada, rellenar resto con ceros
            x(k+2:end) = 0;
            break
        end
    end

    % Actualizar gráfica
    set(ln,'XData',t,'YData',x);
    xlim(ax,[0 T]);
    ylim(ax,[0 max([1 x0 max(x)])]);
    drawnow;
end
end