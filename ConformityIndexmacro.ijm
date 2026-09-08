thresholdMethod = "Default dark";
setOption("BlackBackground", true); 
patternPath = File.openDialog("select pattern image");
open(patternPath);
patternTitle = getTitle();

//ROIs
waitForUser("draw ROIs, t = add current selections to ROI manager");
n = roiManager("count");
if (n == 0) exit;
idx = Array.getSequence(n);
roiManager("Select", idx);
roiManager("Combine");
roiManager("Add");
stripeIndex = roiManager("count") - 1;
roiManager("Select", stripeIndex);
roiManager("Rename", "Stripes_Combined");

run("Set Measurements...", "area redirect=None decimal=3");
stripeArea = getValue("Area");

//substrate ROI 
run("Select All");
roiManager("Add");
substrateIndex = roiManager("count") - 1;
roiManager("Select", substrateIndex);
roiManager("Rename", "Substrate");
substrateArea = getValue("Area");

fractionalArea = stripeArea / substrateArea;
print("Fractional area: " + fractionalArea);
close(patternTitle);

//Separate Channel Area Calc
channels = newArray("Red", "Green", "Blue");

for (c = 0; c < channels.length; c++) {
    chanName = channels[c];
    imgPath = File.openDialog("Select " + chanName + "images");
    open(imgPath);
    origTitle = getTitle();

    if (bitDepth() == 24) {
        run("Split Channels");
        keepTitle = origTitle + " (" + toLowerCase(chanName) + ")";
        allChans = newArray("red", "green", "blue");
        for (k = 0; k < allChans.length; k++) {
            candidate = origTitle + " (" + allChans[k] + ")";
            if (candidate != keepTitle && isOpen(candidate)) close(candidate);
        }
        selectWindow(keepTitle);
        rename(origTitle);
    }

//ROI application
    imgTitle = getTitle();
    setAutoThreshold(thresholdMethod);
    run("Convert to Mask"); // binarizes: foreground=255, background=0

    
    roiManager("Select", stripeIndex);
    getStatistics(nul, nul, nul, nul, nul, histStripe);
    stripeSignalPixels = histStripe[255];

    roiManager("Select", substrateIndex);
    getStatistics(nul, nul, nul, nul, nul, histSub);
    substrateSignalPixels = histSub[255];

//output 
    row = nResults;
    setResult("Label", row, imgTitle);
    setResult("Channel", row, chanName);
    setResult("StripeSignalPixels", row, stripeSignalPixels);
    setResult("SubstrateSignalPixels", row, substrateSignalPixels);
    setResult("FractionalArea", row, fractionalArea);

    if (substrateSignalPixels == 0) {
        setResult("CI", row, NaN);
    } else {
        setResult("CI", row, (stripeSignalPixels / substrateSignalPixels) / fractionalArea);
    }

    updateResults();
    close(imgTitle);
}
