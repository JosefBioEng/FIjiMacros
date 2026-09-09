This is a macro for the semi automation of the analysis of the confomirty of neuralised mouse embryonic stem cells to parylene-C patterning

Tested on ImageJ - Fiji - 1.54p, Java - 21.0.7
https://fiji.sc/

Intructions
1) Load ImageJ
2) Open ConformityIndexmacro.ijm
3) Select run in macro screen
4) Select the image you are tracing the pattern of
5) Trace over pattern using ImageJ's selection tools, once fully selected press "t" to add it to the ROI manager
6) You can copy and paste the selection trace through the ROI manager, and use the same trace when aligning over the remaining patterning
7) Select okay in the dialog box once all patterning has been traced
8) Select neuron (red) channel image
9) Results will update live for each selection in an output table, showing file name, channel, stripe signal pixels, substrate signal pixels, fractional area and CI
10) Repeat for astrocyte (green) and nuclei (blue) channels
11) once results are noted down, close table box and repeat from (2)

This macro can be used outside of previously mentioned channels, it essentially applies the drawn ROI onto each channel images, counts the number of non black pixels present within, and compares it to the number in the original image  

By editing "//Separate Channel Area Calc
channels = newArray("Red", "Green", "Blue");"
You can add or remove channels to the array. To note, the names are irrelevant, it just makes organisation easier.  

Many thanks to Dr Evangelos Delivopoulos for the opportunity to write a dissertation using his research, and to the University of Reading, for an amazing three years.
_"Stand on the shoulders of giants"_
