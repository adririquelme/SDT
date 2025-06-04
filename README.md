
# Spherical Density Tool

**Spherical Density Tool** is a MATLAB-based application (developed using version R2024b) created at the University of Alicante. It is designed for the analysis of discontinuity set orientations by projecting surface normals onto a unit-radius sphere. Unlike traditional stereographic projections, this method avoids distortion by working directly on the spherical surface.

## 🧠 Purpose

This tool enables users to:
- Visualise surface normals as intersection points on a sphere.
- Compute pole density using kernel density estimation (KDE).
- Generate contour plots of density distribution.
- Identify principal orientations of discontinuity sets.
- Represent orientations using Clar notation.

## ✨ Features

- Load `.ply` files containing point clouds with precomputed normals.
- Interactive 3D visualisation of pole positions on the sphere.
- Adjustable density computation parameters:
  - Resolution (`nsec`)
  - Bandwidth (kernel width)
  - Minimum density threshold
  - Number of principal orientations
  - Minimum angular separation between orientations
- Automatic detection of local density maxima.
- Visual output as colour maps and contour plots.
- User-friendly graphical interface (GUI).

## 🚀 How to Use

1. **Load File**: Select a `.ply` file containing the point cloud and associated normals.
2. **Initial Visualisation**: The tool displays the intersection points of the normals with the unit sphere.
3. **Density Calculation**:
   - Set the resolution (`nsec`, typically between 6 and 8).
   - Define the `bandwidth` (sine of an angle, usually between 1° and 2°). A value of `0` enables automatic bandwidth selection.
4. **Peak Detection**:
   - Specify the minimum density threshold (`min density`) as a fraction of the maximum density (e.g., 0.01).
   - Set the number of principal orientations to detect (`N of ppal`) and the minimum angular separation between them (`Max angle`).
5. **Run Analysis**: Click the bar chart button to compute the density, identify peaks, and display the results.

## 📦 Requirements

- MATLAB R2024b
- Computer Vision Toolbox
- No additional toolboxes required
- Compatible with operating systems supported by MATLAB GUI

## 📁 Input Format

- `.ply` file containing a 3D point cloud with surface normals.

## 📌 Additional Notes

- Principal orientations are expressed using Clar notation.
- The analysis is performed directly on the sphere, avoiding projection-related distortions.

## 📄 Licence

This project is licensed under the **MIT Licence**, which permits reuse, modification, and distribution with appropriate attribution.  
See the `LICENSE` file for full details.

## 👤 Author

Developed at the **University of Alicante**.  
For questions, suggestions, or contributions, please open an issue or submit a pull request.

---

