#!/bin/python

import sys
import os
import csv

# Usage: python woodworker.py [input path] [warmup] [verbose]

# Debug printer
def prnt(string):
    global verbose
    if(verbose):
        print(string)

# checking number of parameters
if(len(sys.argv) > 4):
    print("Invalid number of arguments!")
    exit(-1)

# initializing variables
path = "."
warmup = 4
verbose = False
    
if(len(sys.argv) > 1):
    path = sys.argv[1]

if(len(sys.argv) > 2):
    warmup = int(sys.argv[2])
    
if(len(sys.argv) > 3):
    if(sys.argv[3] == "1"):
        verbose = True

iterations = 9 - warmup
    
if(not os.path.isdir(path)):
    print("Error: Path invalid")
    exit(-1)
    
if(warmup > 8):
    print("Error: Invalid warmup number!")
    exit(-1)

# define names for columns
data_header = ["", "Total", "Startup", "File IO", "norm_xcorr", "nxcorr_disp", "frankot_chellappa", "g2s", "cpCorr", "cpCorr matching", "crossSpot4 setup", "crossSpot4 translation", "crossSpot4 match", "crossSpot4 interpolation", "crossSpot4 second pass preperation", "crossSpot4 second pass", "crossSpot4 error correction", "crossSpot4 finalizing", "Loop", "Filter", "crossSpot4", "Correction"]

# define core configuration & allocate space for results
matrices = None

# path to output data
output_path = "table_debug_1.csv"

# allocate space for results of current core configuration
data = [None] * 9
for i in range(9):
    data[i] = [None] * (len(data_header))
    
# write header and row names
data[0] = data_header
data[1][0] = "detectorDistortion (25 Bilder)"
data[2][0] = "Experiment 6 Lenses 200 (21 Bildpaare)"
data[3][0] = "Experiment 6 Lenses 500 (11 Bildpaare)"
data[4][0] = "Experiment 6 Lenses 1500 (14 Bildpaare)"
data[5][0] = "Lenses Set 1 (10 Bildpaare)"
data[6][0] = "Lenses Set 2 (5 Bildpaare)"
data[7][0] = "Lenses Set 3 (1 Bildpaare)"
data[8][0] = "Lenses Set 3 (2 Bildpaare)"

# iterate through all benchmarking configurations
for configuration in range(8):
    if(configuration == 0):    
        # create unique identifier
        uid = "dd"
        offset = 0
        
        # iterate through all profiling points
        for func in range(21):
            if(func == 5 or func == 6):
                # skip reconstructing functions for detector distortion
                data[configuration + 1][func + 1] = 0
                offset = 2                
                continue

            # path for input
            filename = "time_wf_each_" + str(func - offset) + "_" + uid + ".csv"
            filepath = path + "/times_wf/1/" + filename

            # try to read values
            try:
                f = open(filepath, "r")
                line = f.read()
                f.close()
            except:
                prnt("Skiping detector distortion.")
                data[configuration + 1][func + 1] = 0
                continue 
            
            result = 0.0
            
            # average values
            line_split = line.split(",")
            for i in range(warmup, len(line_split) - 1):
                result += float(line_split[i])
                
            data[configuration + 1][func + 1] = result / iterations
            
    else:
        local_configuration = configuration - 1
        script = ""
        
        # Don't benchmark the integration! Always use Frankot-Chellappa!
        integration = 1 #local_configuration % 2
        dataset = ""
        integrationMethod="_" + str(integration) #  1 - Frankot-Chellappa, 2 - grad2Surf
        
        # get dataset name
        if(local_configuration < 3):
            script = "exp6"
            
            if(local_configuration % 3 == 0):
                dataset = "lens_200"
            elif(local_configuration % 3 == 1):
                dataset = "lens_500"
            else:
                dataset = "lens_1500"
        else:        
            script = "lenses"
            
            local_configuration -= 3
            
            if(local_configuration == 0):
                dataset = "set1"
            elif(local_configuration == 1):
                dataset = "set2"
            else:
                dataset = "set3"
                integrationMethod = ""
                if(local_configuration == 2):
                    dataset += "_0"
                else:
                    dataset += "_1"
        
        # create unique identifier
        uid = script + "_" + dataset + integrationMethod
        
        # iterate through all profiling points            
        for func in range(21):
            
            # path for output
            filename = "time_wf_each_" + str(func) + "_" + uid + ".csv"
            filepath = path + "/times_wf/1/" + filename
            
            # try to read values
            try:
                f = open(filepath, "r")
                line = f.read()
                f.close()
            except:
                prnt("Skiping " + script + " " + dataset + ".")
                data[configuration + 1][func + 1] = 0
                continue
            
            result = 0.0
            
            # average values
            line_split = line.split(",")
            for i in range(warmup, len(line_split) - 1):
                result += float(line_split[i])

            data[configuration + 1][func + 1] = result / iterations
            
matrices = data

# save table to disc
with open(output_path, "w") as csv_file:
    csv_writer = csv.writer(csv_file)
    
    for i in range(len(data)):
        csv_writer.writerow(data[i])


# define new names for columns
data_header = ["", "Total", "Startup", "File IO", "Loop", "Correction", "crossSpot4", "frankot_chellappa", "crossSpot4 translation", "crossSpot4 match", "crossSpot4 interpolation", "crossSpot4 second pass", "crossSpot4 error correction"]

main_header = ["", "Präprozessierschritte", "Speckle-Tracking", "Gradientenintegration"]
speckle_header = ["", "starre Verschiebung", "Erster Durchlauf", "Interpolation", "Zweiter Durchlauf", "Fehlerkorrektur"]
slow_header = ["", "Template-Matching", "Subpixel-Interpolation", "Rest zweiter Durchlauf", "Interpolation", "Gradientenintegration"]

# define names for columns
config_header = ["", "detector distortion (25 images)", "experiment 6 lenses 200 (21 image pairs)", "experiment 6 lenses 500 (11 image pairs)", "experiment 6 lenses 1500 (14 image pairs)", "lenses set 1 (10 image pairs)", "lenses set 2 (5 image pairs)", "lenses set 3 (1 image pair)", "lenses set 3 (2 image pairs)"]

# define number of input image pairs
num_image_pairs = [25 * 25, 21, 11, 14, 10, 5, 1, 2]

# allocate space for total time
time_data = [None] * 2
for i in range(2):
    time_data[i] = [None] * len(config_header)
    
# allocate space for round time
round_time_data = [None] * 2
for i in range(2):
    round_time_data[i] = [None] * len(config_header)

# allocate space for speedup
speedup_data = [None] * 2
for i in range(2):
    speedup_data[i] = [None] * len(config_header)

# copy column header into tables
time_data[0] = config_header
round_time_data[0] = config_header
speedup_data[0] = config_header

time_data[1][0] = "1"
round_time_data[1][0] = "1"
speedup_data[1][0] = "1"

# path to output data
output_path = "table_1.csv"
main_path = "main.csv"
slow_path = "slow.csv"
speckle_path = "speckle.csv"

# allocate space for results of current core configuration
data = [None] * 9
for i in range(9):
    data[i] = [None] * (len(data_header))

main = [None] * 9
for i in range(9):
    main[i] = [None] * (len(main_header))
    
slow = [None] * 9
for i in range(9):
    slow[i] = [None] * (len(slow_header))
    
speckle = [None] * 9
for i in range(9):
    speckle[i] = [None] * (len(speckle_header))
    
# write header and row names
main[0] = main_header
slow[0] = slow_header
speckle[0] = speckle_header
data[0] = data_header
main[1][0] = slow[1][0] = speckle[1][0] = data[1][0] = "Detector Distortion (25 Bilder)"
main[2][0] = slow[2][0] = speckle[2][0] = data[2][0] = "Experiment 6 Lenses 200 (21 Bildpaare)"
main[3][0] = slow[3][0] = speckle[3][0] = data[3][0] = "Experiment 6 Lenses 500 (11 Bildpaare)"
main[4][0] = slow[4][0] = speckle[4][0] = data[4][0] = "Experiment 6 Lenses 1500 (14 Bildpaare)"
main[5][0] = slow[5][0] = speckle[5][0] = data[5][0] = "Lenses Set 1 (10 Bildpaare)"
main[6][0] = slow[6][0] = speckle[6][0] = data[6][0] = "Lenses Set 2 (5 Bildpaare)"
main[7][0] = slow[7][0] = speckle[7][0] = data[7][0] = "Lenses Set 3 (1 Bildpaare)"
main[8][0] = slow[8][0] = speckle[8][0] = data[8][0] = "Lenses Set 3 (2 Bildpaare)"

# iterate through all benchmarking configurations
for configuration in range(8):
    
    # copy total time
    data[configuration + 1][1] = matrices[configuration + 1][1]
    # copy startup time
    data[configuration + 1][2] = matrices[configuration + 1][2]
    # copy file IO time
    data[configuration + 1][3] = matrices[configuration + 1][3]
    # copy loop time
    data[configuration + 1][4] = matrices[configuration + 1][18]
    # calculate correction time
    data[configuration + 1][5] = matrices[configuration + 1][21] + matrices[configuration + 1][19]
    # copy crossSpot4 time
    data[configuration + 1][6] = matrices[configuration + 1][20]
    # copy frankot chellappa time
    data[configuration + 1][7] = matrices[configuration + 1][6]
    # calculate crossSpot4 translation time
    data[configuration + 1][8] = matrices[configuration + 1][10] + matrices[configuration + 1][11]
    # copy crossSpot4 first pass time
    data[configuration + 1][9] = matrices[configuration + 1][12]
    # copy crossSpot4 interpolation time
    data[configuration + 1][10] = matrices[configuration + 1][13]
    # calculate crossSpot4 second pass time
    data[configuration + 1][11] = matrices[configuration + 1][14] + matrices[configuration + 1][15]
    # calculate crossSpot4 error correction time
    data[configuration + 1][12] = matrices[configuration + 1][16] + matrices[configuration + 1][17]
    
    # save total time (measured total time - file io time)
    time_data[1][configuration + 1] = data[configuration + 1][1] - data[configuration + 1][3]
    # save round time (loop time / number of image pairs)
    round_time_data[1][configuration + 1] = data[configuration + 1][4] / num_image_pairs[configuration]

    # save speedup
    speedup_data[1][configuration + 1] = 1


    loop_without_file_io = data[configuration + 1][1] - data[configuration + 1][3]
    
    # save main functions
    main[configuration + 1][2] = data[configuration + 1][6] / loop_without_file_io * 100
    main[configuration + 1][3] = data[configuration + 1][7] / loop_without_file_io * 100
    main[configuration + 1][1] = 100 - main[configuration + 1][2] - main[configuration + 1][3]
    
    # save slow functions
    slow[configuration + 1][1] = matrices[configuration + 1][4] / loop_without_file_io * 100
    slow[configuration + 1][2] = matrices[configuration + 1][5] / loop_without_file_io * 100
    slow[configuration + 1][3] = (matrices[configuration + 1][8] - matrices[configuration + 1][4] - matrices[configuration + 1][5]) / loop_without_file_io * 100
    slow[configuration + 1][4] = matrices[configuration + 1][13] / loop_without_file_io * 100
    slow[configuration + 1][5] = matrices[configuration + 1][6] / loop_without_file_io * 100

    # save speckle
    speckle[configuration + 1][1] = data[configuration + 1][8] / loop_without_file_io * 100
    speckle[configuration + 1][2] = data[configuration + 1][9] / loop_without_file_io * 100
    speckle[configuration + 1][3] = data[configuration + 1][10] / loop_without_file_io * 100
    speckle[configuration + 1][4] = data[configuration + 1][11] / loop_without_file_io * 100
    speckle[configuration + 1][5] = data[configuration + 1][12] / loop_without_file_io * 100
    
# save table to disc
with open(output_path, "w") as csv_file:
    csv_writer = csv.writer(csv_file)
    
    for i in range(len(data)):
        csv_writer.writerow(data[i])

# save tables to disc
with open("total_time.csv", "w") as csv_file:
    csv_writer = csv.writer(csv_file)
    
    for i in range(len(time_data)):
        csv_writer.writerow(time_data[i])                

with open("round_time.csv", "w") as csv_file:
    csv_writer = csv.writer(csv_file)
    
    for i in range(len(round_time_data)):
        csv_writer.writerow(round_time_data[i])

with open("speedup.csv", "w") as csv_file:
    csv_writer = csv.writer(csv_file)
    
    for i in range(len(speedup_data)):
        csv_writer.writerow(speedup_data[i])

with open(main_path, "w") as csv_file:
    csv_writer = csv.writer(csv_file)
    
    for i in range(len(main)):
        csv_writer.writerow(main[i])
        
with open(slow_path, "w") as csv_file:
    csv_writer = csv.writer(csv_file)
    
    for i in range(len(slow)):
        csv_writer.writerow(slow[i])
        
with open(speckle_path, "w") as csv_file:
    csv_writer = csv.writer(csv_file)
    
    for i in range(len(speckle)):
        csv_writer.writerow(speckle[i])


