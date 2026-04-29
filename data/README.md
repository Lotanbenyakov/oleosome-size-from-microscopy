Data Requirements

This script is designed to process optical microscopy images for oleosome size extraction. To ensure accurate and reproducible results, the input data should meet the following criteria:

Image Format

* Images must be provided in .tif format.
* Use uncompressed or lossless TIFF files to avoid artifacts that can affect segmentation and circle detection.

Imaging Consistency

* Maintain constant illumination conditions across all images.
* Avoid variations in background brightness, shadows, or gradients.
* Ensure the microscope settings (exposure, gain, magnification) remain unchanged throughout the experiment.

Background Quality

* The background should be as uniform and noise-free as possible.
* Minimize:
    * uneven lighting
    * reflections
    * debris or non-target structures
* High background variability will negatively impact thresholding and object detection.

Sample Preparation

* Oleosomes should be well-dispersed with minimal overlap.
* Avoid clustering or aggregation when possible, as this can interfere with circle detection (imfindcircles).

Calibration

* A pixel-to-micrometer calibration factor is required.
* Ensure calibration corresponds to the exact imaging conditions used (objective lens, camera, resolution).

File Organization

* Place all input images in a single directory (e.g., data/example_images/).
* The script processes all .tif files in the selected folder.

Notes

* This method assumes approximately circular particle morphology.
* Performance depends strongly on image quality and parameter selection (illumination sensitivity, edge threshold, radius bounds).
