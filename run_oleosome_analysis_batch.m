% House Cleaning Before Passover - Modified for Single Sheet Output
clc; clear; close all;
% Set directory where images are stored
selpath = uigetdir;
imageDir = selpath;
imageFiles = dir(fullfile(imageDir, '*.tif'));
nImages = length(imageFiles);

prompt = "Illumination Sensitivity (start with 0.7) ";
txt = input(prompt);
prompt = "EdgeThreshold (Start with 0.49) ";
txt_1 = input(prompt);
prompt = "Mininum Radius (Start with 6) ";
txt_2 = input(prompt);
prompt = "Maxumum Radius (Start with 70) ";
txt_3 = input(prompt);
prompt = "Scale of Microscope for 1um (Insert your calibration ex: recommended for 100x) ";
txt_4 = input(prompt);

% Initialize results table
allResults = [];
histogramBins = 0:0.25:12;

% Initialize a table to store all data
combinedData = table();

% Loop over all images
for i = 1:nImages
    image_name = fullfile(imageDir, imageFiles(i).name);
    
    % Load and process image from directory
    A = imread(image_name);
    A1 = im2bw(A, txt); % illumination sensitivity inputed from prompt
    [centers, radii, ~] = imfindcircles(A1, [txt_2, txt_3], 'EdgeThreshold', txt_1, "ObjectPolarity", "dark", 'Method','PhaseCode');
    
    % Convert radii to micrometers via scale in microscope
    radiiMicrometers = radii / txt_4;
    diameterMicrometers = radiiMicrometers * 2;
    
    % Calculate average diameter
    averageDiameter = mean(diameterMicrometers);
    
    % Create histogram of particle sizes
    particleHistogram = histcounts(diameterMicrometers, histogramBins);
    
    % Create and save a histogram for each image
    figure;
    bar(histogramBins(1:end-1) + 0.25, particleHistogram, 0.5);
    xlabel('Diameter (Micrometers)');
    ylabel('Frequency');
    title(['Histogram of Particle Sizes - ', imageFiles(i).name]);
    histogramFileName = fullfile('Histograms', [erase(imageFiles(i).name, '.tif'), '_Histogram.png']); % Ensure the 'Histograms' folder exists or adjust path
    saveas(gcf, histogramFileName);
    close; % Close the figure to save memory
    
    % Overlay circles on the original image and save
    figure;
    imshow(A); % Display original image
    hold on;
    viscircles(centers, radii, 'EdgeColor', 'r'); % Overlay detected circles
    overlayFileName = fullfile('Overlays', [imageFiles(i).name, '_Overlay.png']); % Ensure the 'Overlays' folder exists or adjust path
    saveas(gcf, overlayFileName);
    close; % Close the figure to save memory
    
    % Prepare data for ExcelTable
    imageData = table(repmat({imageFiles(i).name}, length(diameterMicrometers), 1), diameterMicrometers, ...
        'VariableNames', {'Image_Name', 'Diameter_Micrometers'});
    
    % Combine data for this image with the overall data
    combinedData = [combinedData; imageData]; %#ok<AGROW>
    
    % Store average diameter for the image
   allResults = [allResults; {imageFiles(i).name, averageDiameter}]; %#ok<AGROW>

end

% Convert average results to table
T_Average = cell2table(allResults, 'VariableNames', {'Image_Name', 'Average_Diameter'});

% Write all combined data (diameter measurements)
writetable(combinedData, 'BatchResults_SingleSheet.xlsx', 'Sheet', 'All_Data', 'Range', 'A1');

% Write average diameters starting in column C to avoid overwriting
writetable(T_Average, 'BatchResults_SingleSheet.xlsx', 'Sheet', 'All_Data', 'Range', 'C1');

fprintf('Batch process completed. Results saved to BatchResults_SingleSheet.xlsx\n');
