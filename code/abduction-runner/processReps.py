import glob
import os
import sys
import argparse
import logging
import numpy
import re
# import pandas as pd
from typing import List


def processRequires(projectFileName):
    libDict  = dict()
    data = open(projectFileName,'r', errors='replace', encoding='utf-8').readlines()
    for line in data:
        if "require(" in line:
            p = re.compile('require\((.*)\)')
            m = p.findall(line)
            for lib in m:
                lib = lib.replace('\"','').replace('\'','').replace('../','').replace('./','').strip()
                if lib not in libDict:
                    libDict[lib] = 0
                libDict[lib] = libDict[lib] +1 
            # tokens = line.split("require(")
    sorted_dict = {k: v for k, v in sorted(libDict.items(),  key=lambda item: -item[1])}
    print('libs, count')
    count = 0
    for lib in sorted_dict.keys():
        print(lib,',',libDict[lib])
        count+=1
        if count>30:
            break
            



def processLibs(projectFileName, item, outputFile):
    projectDict  = dict()
    countDict= dict()
    project = ""
    data = open(projectFileName,'r', errors='replace', encoding='utf-8').readlines()
    for line in data:
        if line.startswith("\""+item+"\""):
            continue
        if line.startswith("Analyzing"):
            project = line.replace("Analyzing ","").strip()
            continue
        line = line.strip()
        rep = line.split(',')[0]
        count = int(line.split(',')[1])
        if rep not in projectDict.keys():
            projectDict[rep] = set()
            countDict[rep] = 0
        projectDict[rep].add(project) 
        countDict[rep] = countDict[rep] + count
    # sorted_dict = {k: v for k, v in sorted(projectDict.items(), key=lambda item: -len(item[1]))}
    # print(item+', projects')
    # count = 0
    # for rep in sorted_dict.keys():    
    #     print(rep, ',', len(projectDict[rep]))
    #     count+=1
    #     if count>30:
    #         break
    sorted_dict = {k: v for k, v in sorted(countDict.items(),  key=lambda item: -item[1]* len(projectDict[item[0]]) )}
    print(item+', count, projects')
    count = 0
    for rep in sorted_dict.keys():
        print(rep, ',', countDict[rep],', ', len(projectDict[rep]))
        if(len(projectDict[rep])>1):
             count+=1
        if count>100:
            break


def filterMinOccurrences(projectFileName, occurrences, outputFile):
    item = 'rep'
    projectDict  = dict()
    countDict= dict()
    project = ""
    data = open(projectFileName,'r', errors='replace', encoding='utf-8').readlines()
    for line in data:
        if line.startswith("\""+item+"\""):
            continue
        if line.startswith("Analyzing"):
            project = line.replace("Analyzing ","").strip()
            continue
        line = line.strip()
        columns = line.split(',') 
        #print(line)
        pos = len(columns)-2
        rep = columns[pos]
        count = int(columns[pos+1])

        if rep not in projectDict.keys():
            projectDict[rep] = set()
            countDict[rep] = 0
        projectDict[rep].add(project) 
        countDict[rep] = countDict[rep] + count


    sorted_dict = {k: v for k, v in sorted(projectDict.items(), key=lambda item: -len(item[1]))}
    # print(item+', projects')
    # count = 0
    # for rep in sorted_dict.keys():    
    #     print(rep, ',', len(projectDict[rep]))
    #     count+=1
    #     # if count>30:
    #     #     break
    sorted_dict = {k: v for k, v in sorted(countDict.items(),  key=lambda item: -item[1]) }
    print(item+', count, projects')
    count = 0
    for rep in sorted_dict.keys():
        if(countDict[rep]<=occurrences or len(projectDict[rep])<=occurrences):
            # projects = projectDict[rep]
            projects = ""
            print(rep, ',', countDict[rep],',', len(projectDict[rep]),',', projects)
            count+=1
        # if count>30:
        #     break


def processQueryDiffConfig(projectFileName, outputFile):
    repsDict  = dict()
    project = ""
    data = open(projectFileName,'r', errors='replace', encoding='utf-8').readlines()
    print('project, new, missing, same')
    new = missing = same = 0
    for line in data:
        if line.startswith("\"new\""):
            continue
        if line.startswith("Analyzing"):
            project = line.replace("Analyzing ","").strip()
            continue
        print(project,',', line.strip()) 
        triple = line.split(',')       
        new = new + int(triple[0])
        missing = missing + int(triple[1])
        same = same + int(triple[2])
    print('Total',',', new, ',', missing,',', same)
 

def processQueryReprSinks(projectFileName, outputFile):

    repsProjectDict  = dict()
    repsDict  = dict()
    projectRSDict = dict()
    project = ""
    data = open(projectFileName,'r', errors='replace', encoding='utf-8').readlines()
    for line in data:
        if line.startswith("\"sink\""):
            continue
        if line.startswith("Analyzing"):
            project = line.replace("Analyzing ","").strip()
            continue
        line = line.strip()
        # there are sinks with commas, that complicated the processing  
        columns = line.split(',') 
        #print(line)
        pos = len(columns)-2
        count = int(columns[pos])
        rep = columns[pos+1]

        if rep not in repsProjectDict.keys():
            repsProjectDict[rep] = set()
        repsProjectDict[rep].add(project)
        
        pr = (project, rep) 
        if pr not in projectRSDict.keys():
            projectRSDict[pr] = count
        else: 
            projectRSDict[pr] = projectRSDict[pr] + count    


        if rep not in repsDict.keys():
            repsDict[rep] = count
        else:
            repsDict[rep] = repsDict[rep] + count

        #print(project,', ', line)
    # for project in repsProjectDict.keys():    
    #     print(project, ', ', len(repsProjectDict[project]))
    print('rep,count,projects,w/o outliers, blame')
    sorted_dict = {k: v for k, v in sorted(repsDict.items(), key=lambda item: -item[1])}
    for rep in sorted_dict.keys():
        if rep.startswith("\"") and rep != "\"rep\"":
            projectsCount = len(repsProjectDict[rep])    
            projectCountString = ""
            projectCountDict = dict()
            for project in repsProjectDict[rep]:
                pr = (project, rep) 
                projectCountDict[project] = projectRSDict[pr]
            
            projectCountDict = {k: v for k, v in sorted(projectCountDict.items(), key=lambda item: -item[1])}
            elements = numpy.array(list(projectCountDict.values())) 
            #print(elements)
            mean = numpy.mean(elements) 
            sd = numpy.std(elements)

            final_list = [x for x in projectCountDict.values() if (x > mean - 2 * sd)]
            final_list = [x for x in final_list if (x < mean + 2 * sd)]
            withoutOutliers = sum(final_list)
            projectCountString = str(projectCountDict).replace(',',';')
            print(rep,',',sorted_dict[rep],',', projectsCount,',',withoutOutliers,',',projectCountString)
    
                

def processQueryReprSinksPerProject(projectFileName, outputFile):
    repsProjectDict  = dict()
    repsDict  = dict()
    project = ""
    data = open(projectFileName,'r', errors='replace', encoding='utf-8').readlines()
    print('rep, count')
    for line in data:
        if line.startswith("\"new\""):
            continue
        if line.startswith("Analyzing"):
            project = line.replace("Analyzing ","").strip()
            repsProjectDict[project] = dict()
            continue
        line = line.strip()
        rep = line.split(',')[2]

        repsPerProject = repsProjectDict[project]
        if rep not in repsDict.keys():
            repsDict[rep] = 1
        else:
            repsDict[rep] = repsDict[rep] + 1

        if rep not in repsPerProject.keys():
            repsPerProject[rep] = 1
        else:
            repsPerProject[rep] = repsPerProject[rep] + 1


        #print(project,', ', line)
    for project in repsProjectDict.keys():    
        print(project, ', ', len(repsProjectDict[project]))
        for rep in repsProjectDict[project].keys():    
            print(rep,',', repsProjectDict[project][rep])

def processQueryUnlikelyRep(projectFileName, outputFile):
    repsDict  = dict()
    project = ""
    data = open(projectFileName,'r', errors='replace', encoding='utf-8').readlines()
    print('rep, projects')
    for line in data:
        if line.startswith("\"rep\""):
            continue
        if line.startswith("Analyzing"):
            project = line.replace("Analyzing ","").strip()
            continue
        line = line.strip()
        rep = line.split(',')[0]
        count = line.split(',')[1]
        if rep not in repsDict.keys():
            repsDict[rep] = set()
        repsDict[rep].add(project) 

        # print(project,',', line)
    sorted_dict = {k: v for k, v in sorted(repsDict.items(), key=lambda item: -len(item[1]))}
    for rep in sorted_dict.keys():    
        print(rep, ',', len(repsDict[rep]))


def processVsReprSinks(projectFileName, outputFile):
    projectRSDict  = dict()
    repsDict  = dict()
    project = ""
    data = open(projectFileName,'r', errors='replace', encoding='utf-8').readlines()
    print('rep, projects')
    hasScore = False
    hasLibrary = False
    for line in data:
        if line.startswith("\"sinkNew\""):
            if  "\"score\"" in line:
                hasScore = True
            if  "\"library\"" in line:
                hasLibrary = True
            continue
        if line.startswith("Analyzing"):
            project = line.replace("Analyzing ","").strip()
            continue
        line = line.strip()
        # there are sinks with commas, that complicated the processing  
        columns = line.split(',') 
        #print(line)
        pos = len(columns)-2
        library = ""
        if hasLibrary:
            library = columns[pos+1]
            pos = pos - 1
        if hasScore:
            score = columns[pos+1]
            pos = pos - 1

        sink = columns[pos]
        rep = columns[pos+1] +' lib:'+library
        
        # sink= line.split(',')[0]
        # rep = line.split(',')[1]
        pr = (project, rep) 
        if pr not in projectRSDict.keys():
            projectRSDict[pr] = dict()

        sinkDict = projectRSDict[pr]    
        if sink not in sinkDict.keys():
            sinkDict[sink] = 1
        else:
            sinkDict[sink] = sinkDict[sink] + 1

        if rep not in repsDict.keys():
            repsDict[rep] = 1
        else:
            repsDict[rep] = repsDict[rep] + 1

        #print(project,', ', line)
    oldProject = ""
    for pr in projectRSDict.keys():
        (project, rep) = pr
        sinkDict = projectRSDict[pr]     
        if oldProject != project:
            print(project)
        sinks = list(sinkDict.keys())
        total = sum(sinkDict.values())
        print(rep, ':', sinks,  '=', total)
        oldProject = project
    
    print('=========')
    print('rep, count')
    sorted_dict = {k: v for k, v in sorted(repsDict.items(), key=lambda item: -item[1])}
    for rep in sorted_dict.keys():    
        print(rep,',', repsDict[rep])


parser = argparse.ArgumentParser()
logging.basicConfig(level=logging.INFO, format="[%(levelname)s\t%(asctime)s] %(name)s\t%(message)s")

parser.add_argument("--input", dest="fileName", required=True, type=str)
parser.add_argument("--kind", dest="kind", required=False, type=str, default="diff",
                    choices=["diff", "repr", "reprProject", "unlikely","vs","libs","occurrences","requires"],
                    help="Kind of file to process")
parser.add_argument("--output", dest="outputFileName", required=True, type=str)

parsed_arguments = parser.parse_args()

fileName =  parsed_arguments.fileName
outputFileName =  parsed_arguments.outputFileName
kind = parsed_arguments.kind


{ 'diff':
        lambda fileName:processQueryDiffConfig(fileName, outputFileName), 
  'repr':
        lambda fileName:processQueryReprSinks(fileName, outputFileName),
    'unlikely':
        lambda fileName:processQueryUnlikelyRep(fileName, outputFileName),
    'vs':
        lambda fileName:processVsReprSinks(fileName, outputFileName),
    'reprProject':
        lambda fileName:processQueryReprSinksPerProject(fileName, outputFileName),
    'libs':
        lambda fileName:processLibs(fileName, "lib", outputFileName),
    'occurrences':
        lambda fileName:filterMinOccurrences(fileName, 50000, outputFileName),
    'requires': 
        lambda fileName:processRequires(fileName)       
}[kind](fileName)

# if kind == 'diff':
#     processQueryDiffConfig(fileName, outputFileName)
# else: 
#     if kind == 'repr':
#         processQueryReprSinks(fileName, outputFileName)
#     # "/persistent/experiments/nosql/sinks2.txt")
#     else: 
#         if kind == 'unlikely':
#             processQueryUnlikelyRep(fileName, outputFileName)
#             #(projectFileName = "/persistent/experiments/nosql/unlikely.txt")
#         else: 
#             if kind== 'vs':
#                 processVsReprSinks(fileName, outputFileName)
#             else:
#                 if kind == 'reprProject':
#                     processQueryReprSinksPerProject(fileName, outputFileName)
#                 else:
#                     if kind == "libs":
#                         processLibs(fileName, "lib", outputFileName)
#                     else:
#                         if kind == "occurrences":
#                             filterMinOccurrences(fileName, 50000, outputFileName)
