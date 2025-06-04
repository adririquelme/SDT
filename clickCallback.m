function clickCallback(~, ~, x_grid, y_grid, z_grid, density)
    % Obtener las coordenadas del punto clicado
    point = get(gca, 'CurrentPoint');
    x_click = point(1, 1);
    y_click = point(1, 2);
    z_click = point(1, 3);
    
    % Encontrar el punto más cercano en la malla
    [~, idx] = min(vecnorm([x_grid(:) - x_click, y_grid(:) - y_click, z_grid(:) - z_click], 2, 2));
    
    % Obtener las coordenadas, densidad y normal del punto más cercano
    x_nearest = x_grid(idx);
    y_nearest = y_grid(idx);
    z_nearest = z_grid(idx);
    density_nearest = density(idx);
    normal_nearest = [x_nearest, y_nearest, z_nearest];
    
    % Calcular dip direction y dip
    dip_direction = atan2d(y_nearest, x_nearest);
    dip = acosd(z_nearest / norm(normal_nearest));
    
    % Mostrar la información en la figura
    info_str = sprintf('Coord: (%.2f, %.2f, %.2f)\nDensidad: %.2f\nDip Dir: %.2f\nDip: %.2f', ...
        x_nearest, y_nearest, z_nearest, density_nearest, dip_direction, dip);
    text(x_nearest, y_nearest, z_nearest, info_str, 'FontSize', 10, 'Color', 'k', ...
        'HorizontalAlignment', 'left', 'BackgroundColor', 'w', 'EdgeColor', 'k');
end