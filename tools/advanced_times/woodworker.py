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
cores = 1
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
core_configurations = [1, 2, 4, 8, 11, 12, 13, 16, 20, 24]
core_index = 0
matrices = [0] * len(core_configurations)

# iterate through all core configurations
for cores in core_configurations:
    # path to output data
    output_path = "table_debug_" + str(cores) + ".csv"

    # allocate space for results of current core configuration
    data = [None] * 9
    for i in range(9):
        data[i] = [None] * (len(data_header))

    # write header and row names
    data[0] = data_header
    data[1][0] = "Detector Distortion (25 Bilder)"
    data[2][0] = "Experiment 6 Lenses 200 (21 Bildpaare)"
    data[3][0] = "Experiment 6 Lenses 500 (11 Bildpaare)"
    data[4][0] = "Experiment 6 Lenses 1500 (14 Bildpaare)"
    data[5][0] = "Lenses Set 1 (10 Bildpaare)"
    data[6][0] = "Lenses Set 2 (5 Bildpaare)"
    data[7][0] = "Lenses Set 3 (1 Bildpaar)"
    data[8][0] = "Lenses Set 3 (2 Bildpaare)"

    # iterate through all benchmarking configurations
    for configuration in range(8):
        if(configuration == 0):    
            # create unique identifier
            uid = "dd"
            
            y = 1
            x = 1

            # iterate through all profiling points
            for func in range(19):
                if(func == 5):
                    # skip reconstructing functions for detector distortion
                    data[y][x] = 0
                    x += 1
                    data[y][x] = 0
                    x += 1
        
                # path for input
                filename = "time_wf_each_" + str(func) + "_" + uid + ".csv"
                filepath = path + "/times_wf/" + str(cores) + "/" + filename

                # try to read values
                try:
                    f = open(filepath, "r")
                    line = f.read()
                    f.close()
                except:
                    prnt("Skiping detector distortion.")
                    data[y][x] = 0
                    x += 1
                    continue
    
                result = 0.0

                # average values
                line_split = line.split(",")
                for i in range(warmup, len(line_split) - 1):
                    result += float(line_split[i])
    
                data[y][x] = result / iterations
                x += 1
                                        
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
                        dataset += "_A"
                    else:
                        dataset += "_Be"
            
            # create unique identifier
            uid = script + "_" + dataset + integrationMethod

            # iterate through all profiling points            
            for func in range(21):
            
                # path for output
                filename = "time_wf_each_" + str(func) + "_" + uid + ".csv"
                filepath = path + "/times_wf/" + str(cores) + "/" + filename

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

    matrices[core_index] = data
    core_index += 1

    # save table to disc
    with open(output_path, "w") as csv_file:
        csv_writer = csv.writer(csv_file)
    
        for i in range(len(data)):
            csv_writer.writerow(data[i])


# define new names for columns
data_header = ["", "Total", "Startup", "File IO", "Loop", "Correction", "crossSpot4", "frankot_chellappa", "crossSpot4 translation", "crossSpot4 match", "crossSpot4 interpolation", "crossSpot4 second pass", "crossSpot4 error correction"]

# define names for columns
config_header = ["", "Detector Distortion (25 Bilder)", "Experiment 6 Lenses 200 (21 Bildpaare)", "Experiment 6 Lenses 500 (11 Bildpaare)", "Experiment 6 Lenses 1500 (14 Bildpaare)", "Lenses Set 1 (10 Bildpaare)", "Lenses Set 2 (5 Bildpaare)", "Lenses Set 3 (1 Bildpaar)", "Lenses Set 3 (2 Bildpaare)"]

#define names for rows
core_config_header = ["1", "2", "4", "8", "11", "12", "13", "16", "20", "24"]

# define number of input Bildpaare
num_image_pairs = [25 * 25, 21, 11, 14, 10, 5, 1, 2]

# allocate space for total time
time_data = [None] * (len(core_config_header) + 1)
for i in range(len(core_config_header) + 1):
    time_data[i] = [None] * len(config_header)
    
# allocate space for round time
round_time_data = [None] * (len(core_config_header) + 1)
for i in range(len(core_config_header) + 1):
    round_time_data[i] = [None] * len(config_header)

# allocate space for speedup
speedup_data = [None] * (len(core_config_header) + 1)
for i in range(len(core_config_header) + 1):
    speedup_data[i] = [None] * len(config_header)

# copy column header into tables
time_data[0] = config_header
round_time_data[0] = config_header
speedup_data[0] = config_header

# copy row header into tables
for core_index in range(len(core_config_header)):    
    time_data[core_index + 1][0] = core_config_header[core_index]
    round_time_data[core_index + 1][0] = core_config_header[core_index]
    speedup_data[core_index + 1][0] = core_config_header[core_index]

core_index = 0

# iterate through all core configurations
for cores in core_configurations:
    # path to output data
    output_path = "table_" + str(cores) + ".csv"

    # allocate space for results of current core configuration
    data = [None] * 9
    for i in range(9):
        data[i] = [None] * (len(data_header))

    # write header and row names
    data[0] = data_header
    data[1][0] = "Detector Distortion (25 Bilder)"
    data[2][0] = "Experiment 6 Lenses 200 (21 Bildpaare)"
    data[3][0] = "Experiment 6 Lenses 500 (11 Bildpaare)"
    data[4][0] = "Experiment 6 Lenses 1500 (14 Bildpaare)"
    data[5][0] = "Lenses Set 1 (10 Bildpaare)"
    data[6][0] = "Lenses Set 2 (5 Bildpaare)"
    data[7][0] = "Lenses Set 3 (1 Bildpaar)"
    data[8][0] = "Lenses Set 3 (2 Bildpaare)"

    # iterate through all benchmarking configurations
    for configuration in range(8):

        # copy total time
        data[configuration + 1][1] = matrices[core_index][configuration + 1][1]
        # copy startup time
        data[configuration + 1][2] = matrices[core_index][configuration + 1][2]
        # copy file IO time
        data[configuration + 1][3] = matrices[core_index][configuration + 1][3]
        # copy loop time
        data[configuration + 1][4] = matrices[core_index][configuration + 1][18]
        # calculate correction time
        data[configuration + 1][5] = matrices[core_index][configuration + 1][21] + matrices[core_index][configuration + 1][19]
        # copy crossSpot4 time
        data[configuration + 1][6] = matrices[core_index][configuration + 1][20]
        # copy frankot chellappa time
        data[configuration + 1][7] = matrices[core_index][configuration + 1][6]
        # calculate crossSpot4 translation time
        data[configuration + 1][8] = matrices[core_index][configuration + 1][10] + matrices[core_index][configuration + 1][11]
        # copy crossSpot4 first pass time
        data[configuration + 1][9] = matrices[core_index][configuration + 1][12]
        # copy crossSpot4 interpolation time
        data[configuration + 1][10] = matrices[core_index][configuration + 1][13]
        # calculate crossSpot4 second pass time
        data[configuration + 1][11] = matrices[core_index][configuration + 1][14] + matrices[core_index][configuration + 1][15]
        # calculate crossSpot4 error correction time
        data[configuration + 1][12] = matrices[core_index][configuration + 1][16] + matrices[core_index][configuration + 1][17]
        
        # save total time (measured total time - file io time)
        time_data[core_index + 1][configuration + 1] = data[configuration + 1][1] - data[configuration + 1][3]
        # save round time (loop time / number of Bildpaare)
        round_time_data[core_index + 1][configuration + 1] = data[configuration + 1][4] / num_image_pairs[configuration]

        # save speedup
        if(cores == 1):
            speedup_data[core_index + 1][configuration + 1] = 1
        else:
            try:
                speedup_data[core_index + 1][configuration + 1] = time_data[1][configuration + 1] / time_data[core_index + 1][configuration + 1]
            except:
                prnt("Skiping configuration " + str(configuration) + " in " + str(core_configurations[core_index]) + " core configuration.")
                speedup_data[core_index + 1][configuration + 1] = 0
                continue
    
    # save table to disc
    with open(output_path, "w") as csv_file:
        csv_writer = csv.writer(csv_file)
    
        for i in range(len(data)):
            csv_writer.writerow(data[i])
            
    core_index += 1

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
