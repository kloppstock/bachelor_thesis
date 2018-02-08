#!/bin/python

# only needed in python 2
from __future__ import print_function

import filecmp
import sys
from filecmp import dircmp

ret = 0

# number of iterations
iterations = 5
# number of iterations for warmup phase
warmup = 4
        
for cores in [1, 2, 4, 8, 11, 12, 13, 16, 20, 24]:
    for configuration in range(6):
        # configuration = int(sys.argv[1])
        # cores = int(sys.argv[2])
    
        # path to output data
        data_path = "benchmark_" + str(cores) + "/"
    
        # path to reference data
        ref_path = "reference"
        
        if(configuration == 0):    
            # create unique identifier
            uid = "dd"
            
            for i in range(iterations + warmup):
                # path for output
                rel_path = "results_" + uid + "/" + str(i)
                ref = ref_path + "/" + rel_path
                pathOutput = data_path + rel_path
                
                print("Comparing " + pathOutput + " and " + ref + " ... ", end='')
                result = dircmp(pathOutput, ref)
                
                if(len(result.diff_files) == 0 and len(result.left_only) == 0):
                    print("done")
                else:
                    ret = -1
                    print("fail")
                    
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
                rel_path = "result_" + uid + "/" + str(i)
                ref = ref_path + "/" + rel_path
                pathOutput = data_path + rel_path                
                
                print("Comparing " + pathOutput + " and " + ref + " ... ", end='')
                result = dircmp(pathOutput, ref)
                
                if(len(result.diff_files) == 0 and len(result.left_only) == 0):
                    print("done")
                else:
                    print("fail")
                    ret = -1
                
exit(ret)
