#!/bin/python

import sys
import os
import numpy as np

def parse_times(filepath, num):
    if(num < 2):
        raise ValueError("num must be at least 2!")
    
    out_lines = [0] * num
    out= [0.0] * num
    
    f = open(filepath, "r")
    for line in (line for line in f if line.rstrip('\n')):
        for l in range(num - 1):
            out_lines[l] = out_lines[l + 1]

        out_lines[num - 1] = line
    f.close()

    for line_number in range(len(out_lines)):
        out[line_number] = float(out_lines[line_number].split(';')[0].split('time: ')[1])
    
    return out

# number of iterations
iterations = 5
# number of iterations for warmup phase
warmup = 4
# core configuration
cores = 1

for configuration in range(7):

    configuration = 1
    
    num_param = 0
    data = [0] * (iterations + warmup)
    
    # path to output data
    data_path = "benchmark_" + str(cores)
    
    out_path = "times_wf/" + str(cores)
    
    if(configuration == 0):    
        # create unique identifier
        uid = "dd"
        num_param = 13
        
        for i in range(iterations + warmup):
            # path for output
            filename = "out_" + uid + "_" + str(i)
            filepath = data_path + "/" + filename
        
            data[i] = parse_times(filepath, num_param)
            
    else:
        local_configuration = configuration - 1
        script = ""
        num_param = 21
        
        # Don't benchmark the integration! Always use Frankot-Chellappa!
        integration = 1 #local_configuration % 2
        dataset = ""
        
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
            
            if(local_configuration % 3 == 0):
                dataset = "set1"
            elif(local_configuration % 3 == 1):
                dataset = "set2"
            else:
                dataset = "set3"
                
        integrationMethod=integration #  1 - Frankot-Chellappa, 2 - grad2Surf
        
        # create unique identifier
        uid = script + "_" + dataset + "_" + str(integration)
        
        for i in range(warmup + iterations):
            filename = "out_" + uid + "_" + str(i)
            filepath = data_path + "/" + filename

            data[i] = parse_times(filepath, num_param)
            
            #(total, startup, read_save, norm_xcorr, nxcorr_disp, frankot_chellappa, g2s, cpCorr, cpCorr_match, cs4_setup, cs4_trans, cs4_match, cs4_interpol, cs4_2nd_pass_prep, cs4_2nd_pass, cs4_error, cs4_final, loop, filt, crossSpot4, correction) = tuple(data[i])

    for p in range(num_param):
        d = [list(i) for i in zip(*data)]
        os.system("mkdir -p " + out_path)
        csv_filename = out_path + "/time_wf_each_" + str(p) + "_" + uid + ".csv"
        arr = np.asarray(d[p])
        print(arr)
        np.savetxt(csv_filename, arr, fmt="%f", delimiter=",", newline=",")
    
