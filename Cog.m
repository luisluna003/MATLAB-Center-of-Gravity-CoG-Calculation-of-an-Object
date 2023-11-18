% Read the STL file
% Replace '3Dmodel.stl' with the path to your STL file
[vertices, faces] = stlRead('3Dmodel.stl');

% Initialize variables for centroid and total area
totalArea = 0;
centroidSum = [0, 0, 0];

% Iterate over all faces
for i = 1:size(faces, 1)
    % Get vertices of the triangle
    v1 = vertices(faces(i, 1), :);
    v2 = vertices(faces(i, 2), :);
    v3 = vertices(faces(i, 3), :);

    % Calculate the centroid of the triangle
    triangleCentroid = (v1 + v2 + v3) / 3;

    % Calculate the area of the triangle
    % Cross product of vectors v1v2 and v1v3 gives twice the area of the triangle
    triangleArea = norm(cross(v2 - v1, v3 - v1)) / 2;

    % Summing up centroids weighted by their area
    centroidSum = centroidSum + triangleCentroid * triangleArea;

    % Summing up total area
    totalArea = totalArea + triangleArea;
end

% Calculate the center of gravity
centerOfGravity = centroidSum / totalArea;

% Display the result
disp('Center of Gravity:');
disp(centerOfGravity);

% Plotting the STL model
figure;
patch('Faces', faces, 'Vertices', vertices, 'FaceColor', [0.8 0.8 1.0], 'EdgeColor', 'none');
camlight;
lighting gouraud;
axis equal;

% Plotting the center of gravity
hold on;
plot3(centerOfGravity(1), centerOfGravity(2), centerOfGravity(3), 'r*', 'MarkerSize', 10);
title('3D Model with Center of Gravity');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
