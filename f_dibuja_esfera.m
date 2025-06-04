function [h] = f_dibuja_esfera(x_grid, y_grid, z_grid, density, alpha, offset)
% Dibujar la densidad en la superficie de la esfera
% Inputs:
% - x_grid, y_grid, z_grid, density
% - alpha = 15; % Hasta donde llegan las líneas desde los polos
% - offset = 0.1; % Separación desde la superficie para las etiquetas
% Ouput:
% - h: handle de la figura que he creado
h=figure;

% Ahora dibujo la densidad
s = surf(x_grid, y_grid, z_grid, density, 'EdgeColor', 'none');
s.FaceAlpha = 1;
s.FaceColor = 'interp'; % FaceColor — Color de cara 'flat' (predeterminado) | 'interp' | 'none' | 'texturemap' | Triplete RGB | código de color hexadecimal | 'r' | 'g' | 'b' | ...
s.EdgeColor = 'interp'; % EdgeColor — Color de línea de borde [0 0 0] (predeterminado) | 'none' | 'flat' | 'interp' | Triplete RGB | código de color hexadecimal | 'r' | 'g' | 'b' | ...
s.LineStyle='-'; % LineStyle — Estilo de línea "-" (predeterminado) | "--" | ":" | "-." | "none"
cmap=colormap(jet);
colorbar;
axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Densidad de eventos en la superficie de una esfera');
% Ajusto los límites a la densidad
mind=min(min(density));
maxd=max(max(density));
g=gca;
g.CLim=[mind maxd];

hold on
% Añadir la estructura alámbrica de la esfera en azul
[theta_wire, phi_wire] = meshgrid(linspace(0, 2*pi, 24), linspace(0, pi-alpha*pi/180, 12));
x_wire = sin(phi_wire) .* cos(theta_wire);
y_wire = sin(phi_wire) .* sin(theta_wire);
z_wire = cos(phi_wire);
m = mesh(x_wire, y_wire, z_wire, 'EdgeColor', 'b', 'FaceAlpha', 0);
m.LineStyle = '--';
% Añadir el ecuador (línea roja)
theta_eq = linspace(0, 2*pi, 100);
x_eq = cos(theta_eq);
y_eq = sin(theta_eq);
z_eq = zeros(size(theta_eq));
plot3(x_eq, y_eq, z_eq, 'r--', 'LineWidth', 2);
% Añadir los meridianos principales (líneas rojas discontinuas)
phi_mer = linspace(0, 2*pi, 100);
x_mer1 = sin(phi_mer);
y_mer1 = zeros(size(phi_mer));
z_mer1 = cos(phi_mer);
plot3(x_mer1, y_mer1, z_mer1, 'r--', 'LineWidth', 2);
x_mer2 = sin(phi_mer) .* cos(pi/2);
y_mer2 = sin(phi_mer) .* sin(pi/2);
z_mer2 = cos(phi_mer);
plot3(x_mer2, y_mer2, z_mer2, 'r--', 'LineWidth', 2);



% Añadir etiquetas en las coordenadas especificadas con recuadro blanco y marco negro
text(0, 1 + offset, 0, 'N', 'FontSize', 12, 'Color', 'k', 'HorizontalAlignment', 'center', 'BackgroundColor', 'w', 'EdgeColor', 'k');
text(0, -1 - offset, 0, 'S', 'FontSize', 12, 'Color', 'k', 'HorizontalAlignment', 'center', 'BackgroundColor', 'w', 'EdgeColor', 'k');
text(1 + offset, 0, 0, 'E', 'FontSize', 12, 'Color', 'k', 'HorizontalAlignment', 'center', 'BackgroundColor', 'w', 'EdgeColor', 'k');
text(-1 - offset, 0, 0, 'W', 'FontSize', 12, 'Color', 'k', 'HorizontalAlignment', 'center', 'BackgroundColor', 'w', 'EdgeColor', 'k');

hold off

end