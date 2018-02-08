#!/bin/python

import sys
import os
import numpy as np

# number of iterations
iterations = 5
# number of iterations for warmup phase
warmup = 4

for cores in [1, 2, 4, 8, 11, 12, 13, 16, 20, 24]:
    for configuration in range(7):
        data = [0.0] * (warmup + iterations)
    
        # path to output data
        data_path = "benchmark_" + str(cores)

        out_path = "times/" + str(cores)
        
        if(configuration == 0):    
            # create unique identifier
            uid = "dd"
            
            for i in range(iterations + warmup):
                # path for output
                filename = "time_" + uid + "_" + str(i)
                filepath = data_path + "/" + filename

                f = open(filepath, "r")
                data[i] = float(f.read())
                f.close()
                                    
        else:
            local_configuration = configuration - 1
            script = ""
            
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
                filename = "time_" + uid + "_" + str(i)
                filepath = data_path + "/" + filename

                f = open(filepath, "r")
                data[i] = float(f.read())
                f.close()
                              
        os.system("mkdir -p " + out_path)  
        csv_filename = out_path + "/time_" + uid + ".csv"
        arr = np.asarray(data)
        np.savetxt(csv_filename, arr, fmt="%.f", delimiter=",", newline=",")
