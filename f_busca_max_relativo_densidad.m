function [relative_maxima, top_N_density, top_N_positions, top_N_normals ] = f_busca_max_relativo_densidad(x_grid, y_grid, z_grid, density, densidadminima, resolucion, angle_limit, N)
% Inputs:
% - x_grid, y_grid, z_grid
% - density
% - densidadminima
% - resolucion = +360/3; % Número de saltos para definir la precisión de la densidad
% - angle_limit = 20; % Límite de ángulo en grados para la selección de máximos relativos
% - N = 10; % Número de puntos de mayor densidad
% Output:
% relative_maxima, 
% top_N_density, 
% top_N_positions, 
% top_N_normals 

densidadminima=densidadminima*max(max(density));
grid_points = [x_grid(:), y_grid(:), z_grid(:)];
relative_maxima = [];
for i = 1:resolucion
    for j = 1:resolucion
        if i == 1 || i == resolucion || j == 1 || j == resolucion
            current_point = [x_grid(i, j), y_grid(i, j), z_grid(i, j)];
            [indices, ~] = knnsearch(grid_points, current_point, 'K', 9);
            neighbors = density(indices(2:end));
            if density(i, j) > densidadminima && all(density(i, j) >= neighbors)
                relative_maxima = [relative_maxima; x_grid(i, j), y_grid(i, j), z_grid(i, j), density(i, j)];
            end
        else
            neighbors = [density(i-1, j-1), density(i-1, j), density(i-1, j+1), ...
                         density(i, j-1), density(i, j+1), ...
                         density(i+1, j-1), density(i+1, j), density(i+1, j+1)];
            if density(i, j) > densidadminima && all(density(i, j) > neighbors)
                relative_maxima = [relative_maxima; x_grid(i, j), y_grid(i, j), z_grid(i, j), density(i, j)];
            end
        end
    end
end
% Ordenar los máximos relativos por densidad de mayor a menor
relative_maxima = sortrows(relative_maxima, -4);

cos_angle_limit = cos(deg2rad(angle_limit));
top_N_density = [];
top_N_positions = [];
top_N_normals = [];
for i = 1:size(relative_maxima, 1)
    if length(top_N_density) >= N
        break;
    end
    normal = relative_maxima(i, 1:3);
    if isempty(top_N_normals)
        top_N_density = [top_N_density; relative_maxima(i, 4)];
        top_N_positions = [top_N_positions; normal];
        top_N_normals = [top_N_normals; normal];
    else
        valid = true;
        for j = 1:size(top_N_normals, 1)
            projection = abs(dot(normal, top_N_normals(j, :)) / (norm(normal) * norm(top_N_normals(j, :))));
            if projection > cos_angle_limit
                valid = false;
                break;
            end
        end
        if valid
            top_N_density = [top_N_density; relative_maxima(i, 4)];
            if normal(3)<0 % Si el vector normal está en el hemisferio inferior, lo invierto para que apunte al hemisferio superior
                normal=-normal;
            end
            top_N_positions = [top_N_positions; normal];
            top_N_normals = [top_N_normals; normal];
        end
    end
end

end