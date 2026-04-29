# oleosome-size-from-microscopy
MATLAB implementation for extracting oleosome size distributions from optical microscopy images via segmentation and object-based analysis. Supports the methodology described in the following publication: https://www.mdpi.com/2079-9284/12/4/158

Overview

This repository provides a batch-processing script for detecting oleosomes in microscopy images and quantifying their size distribution. The method is based on image binarization and circular object detection using MATLAB’s imfindcircles.

The script processes all .tif images in a selected directory and outputs:

* Diameter measurements (µm)
* Per-image histograms
* Overlay images showing detected oleosomes
* A combined Excel file with all results

// REPO LAYOUT
--scripts/
  -run_oleosome_analysis.m
--data/
  -example_images/
--Histograms/        % required output folder in root
--Overlays/          % required output folder in root

--results/           % optional (not used by script directly)
--docs/              % optional notes on experimental parameters

Requirements
* MATLAB (tested with versions supporting imfindcircles)
* Image Processing Toolbox

Usage
1. Ensure the following folders exist in the project root:
--Histograms/        % required output folder in root
--Overlays/          % required output folder in root
2. Place .tif images in a directory (e.g., data/example_images/)
3. Run the script:
run('scripts/run_oleosome_analysis.m')
4. When prompted, provide:
    * Illumination sensitivity (e.g., 0.7)
    * Edge threshold (e.g., 0.49)
    * Minimum radius (pixels)
    * Maximum radius (pixels)
    * Microscope calibration (pixels per µm)
   Note: The parameters will be to be tested and calculated according to your microscope with a standard

Output

* BatchResults_SingleSheet.xlsx
    * Sheet: All_Data
    * Contains:
        * Individual particle diameters
        * Average diameter per image
* Histograms/
    * Histogram plots for each image
* Overlays/
    * Original images with detected circles overlaid

Data Requirements

* Images must be in .tif format
* Maintain consistent illumination and imaging conditions across all samples
* Background should be uniform with minimal noise
* Oleosomes should be reasonably well-separated (limited overlap)
* Calibration must match imaging setup (objective, resolution)

Notes

* The method assumes approximately circular particle morphology
* Detection performance depends on parameter tuning and image quality
* im2bw is used for binarization (may be deprecated in newer MATLAB versions)

License

This project is licensed under the MIT License.

Citation

If you use this code in any shape or form, please cite:

Dynamic vs. Static Light Scattering: Evaluating the Tandem Use of Optical Microscopy and DLS for Particle Characterization
https://www.mdpi.com/2079-9284/12/4/158

Contact
Questions can be directed to Lotan Ben Yakov (see author list in the publication).   
