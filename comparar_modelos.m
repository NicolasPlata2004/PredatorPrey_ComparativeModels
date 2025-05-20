function comparar_modelos
% Comparación visual entre:
% (1) Modelo clásico de Lotka–Volterra (oscilatorio)
% (2) Modelo chochín–gato (depredador fijo)

%% PARÁMETROS COMUNES
T = 20;         % tiempo total (años)
dt = 0.01;      % paso de tiempo
N = floor(T/dt) + 1;
t = linspace(0, T, N);

%% (1) MODELO LOTKA–VOLTERRA
% Variables: H = presas (e.g., conejos), L = depredadores (e.g., zorros)
% Ecuaciones:
%   dH/dt = r*H - a*H*L
%   dL/dt = b*H*L - d*L

% Parámetros LV
r  = 1.0;
a  = 0.1;
b  = 0.075;
d  = 1.5;

% Condiciones iniciales
H = zeros(1, N);  L = zeros(1, N);
H(1) = 40;        L(1) = 9;

% Simulación
for k = 1:N-1
    dH = r * H(k) - a * H(k) * L(k);
    dL = b * H(k) * L(k) - d * L(k);
    H(k+1) = max(H(k) + dt * dH, 0);
    L(k+1) = max(L(k) + dt * dL, 0);
end

%% (2) MODELO CHOCHÍN–GATO
% Variable: x = chochines
% Ecuación:
%   dx/dt = r*x*(1 - x/K) - alpha*z*x

% Parámetros chochín
rc     = 0.4;
K      = 300;
alpha = 0.061;
z      = 10;

% Condición inicial
x = zeros(1, N);
x(1) = 250;

% Simulación
for k = 1:N-1
    dx = rc * x(k) * (1 - x(k)/K) - alpha * z * x(k);
    x(k+1) = max(x(k) + dt * dx, 0);
end

%% GRAFICAR COMPARACIÓN
figure;

subplot(2,1,1)
plot(t, H, 'b', 'LineWidth', 2); hold on;
plot(t, L, 'r--', 'LineWidth', 2);
xlabel('Tiempo [años]');
ylabel('Población');
title('Modelo clásico Lotka–Volterra');
legend('Presas (H)', 'Depredadores (L)');
grid on;

subplot(2,1,2)
plot(t, x, 'm', 'LineWidth', 2);
xlabel('Tiempo [años]');
ylabel('Población de chochines');
title('Modelo chochín–gato (depredador constante)');
grid on;

end
