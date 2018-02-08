#!/bin/python

import sys
import os

if(len(sys.argv) > 4):
    print("Invalid number of arguments!")
    exit(-1)

path = "."
output_path = "times.csv"
warmup = 4
    
if(len(sys.argv) > 1):
    path = sys.argv[1]
    
if(len(sys.argv) > 2):
    output_path = sys.argv[2]

if(len(sys.argv) > 3):
    warmup = int(sys.argv[3])
    
iterations = 9 - warmup
    
if(not os.path.isdir(path)):
    print("Error: Path invalid")
    exit(-1)
    
if(warmup > 8):
    print("Error: Invalid warmup number!")
    exit(-1)
    
data = ",total, startup, read_save, norm_xcorr, nxcorr_disp, frankot_chellappa, g2s, cpCorr, cpCorr_match, cs4_setup, cs4_trans, cs4_match, cs4_interpol, cs4_2nd_pass_prep, cs4_2nd_pass, cs4_error, cs4_final, loop, filt, crossSpot4, correction\n"

for configuration in range(6):
        
    # path to output data
    data_path = "table.csv"
    
    if(configuration == 0):    
        # create unique identifier
        uid = "dd"
        
        data += '"Detector Distortion",'
        
        for func in range(19):
            if(func == 5):
                data += ", , " # skip reconstructing functions
                
            cores = 1
    
            # path for output
            filename = "time_wf_each_" + str(func) + "_" + uid + ".csv"
            filepath = path + "/times_wf/" + str(cores) + "/" + filename
            
            f = open(filepath, "r")
            line = f.read()
            f.close()

            result = 0.0
            
            line_split = line.split(",")
            for i in range(warmup, len(line_split) - 1):
                result += float(line_split[i])
            
            data += str(result / iterations) + ","
                                    
    else:
        local_configuration = configuration - 1
        script = ""
        
        # Don't benchmark the integration! Always use Frankot-Chellappa!
        integration = 1 #local_configuration % 2
        dataset = ""
        
        if(local_configuration < 3):
            script = "exp6"
            data += '"Experiment 6 Lenses '
            
            if(local_configuration % 3 == 0):
                dataset = "lens_200"
                data += '200'
            elif(local_configuration % 3 == 1):
                dataset = "lens_500"
                data += '500'
            else:
                dataset = "lens_1500"
                data += '1500'
        else:        
            script = "lenses"
            data += '"Lenses Set '
            
            if(local_configuration % 3 == 0):
                dataset = "set1"
                data += '1'
            elif(local_configuration % 3 == 1):
                dataset = "set2"
                data += '2'
            else:
                dataset = "set3"
                data += '3'

        data += '",'
                
        integrationMethod=integration #  1 - Frankot-Chellappa, 2 - grad2Surf
        
        # create unique identifier
        uid = script + "_" + dataset + "_" + str(integration)

        for func in range(21):
            cores = 1
        
            # path for output
            filename = "time_wf_each_" + str(func) + "_" + uid + ".csv"
            filepath = path + "/times_wf/" + str(cores) + "/" + filename

            f = open(filepath, "r")
            line = f.read()
            f.close()

            result = 0.0
            
            line_split = line.split(",")
            for i in range(warmup, len(line_split) - 1):
                result += float(line_split[i])

            data += str(result / iterations) + ","

    data += "\n"

out = open(output_path, "w")
out.write(data)
out.close()
