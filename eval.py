#!/bin/python3

import argparse
import json
import ast

def get_number_from_filename(filename):
    output = filename.split("/")[-1]
    output = output.split(".")[0]
    output = output.split("_")[0]
    return int(output)

def get_ground_truth_values(filename):
    output = []
    with open(filename) as file:
        output = file.readlines()
    output = [x.rstrip() for x in output]
    return output

def get_word_error(word1,word2,ignorecase):
    if ignorecase:
        word1 = word1.lower()
        word2 = word2.lower()
    if word1 == word2:
        return 0
    else:
        return 1

def get_character_error(word1,word2,ignorecase):
    if ignorecase:
        word1 = word1.lower()
        word2 = word2.lower()
    if word1 == word2:
        return 0
    elif len(word1) == 0 and len(word2) > 0:
        return 1.0
    else:
        return levenshtein(word1,word2) / len(word2)

def levenshtein(s,t, cost_delins=1, cost_subst=1):
    ''' Wagner-Fscher algorithm to compute the edit distance between two words s and t. Default cost of deletion/insertion as well as substitution is 1 '''
    s = "-"+s # index alignment
    t = "-"+t
    d = [[0 for i in range(len(t))] for j in range(len(s))]
    for i in range(1,len(s)):
        d[i][0] = i
    for j in range(1,len(t)):
        d[0][j] = j
    for j in range (1,len(t)):
        for i in range(1,len(s)):
            if s[i] == t[j]:
                cost = 0
            else:
                cost = cost_subst
            d[i][j] = min(  d[i-1][j] + cost_delins,    # deletion
                            d[i][j-1] + cost_delins,    # insertion
                            d[i-1][j-1] + cost)         # substitution
    # print(*d,sep="\n")
    return d[-1][-1]


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("input", help="detection results")
    parser.add_argument("groundtruth", help="groundtruth text file")
    parser.add_argument("--ignorecase", action='store_true', help="set to don't count wrong case as an error")
    args = parser.parse_args()
    inputs = ast.literal_eval(args.input)
    ground_truth_values = get_ground_truth_values(args.groundtruth)
    total_w_error = 0
    total_c_error = 0
    for detection in inputs:
        idx = get_number_from_filename(detection[0])
        detected_label = detection[1]
        ground_truth_label = ground_truth_values[idx]
        c_error = get_character_error(ground_truth_label, detected_label,args.ignorecase)
        total_c_error += c_error
        total_w_error += get_word_error(ground_truth_label,detected_label,args.ignorecase)
        print(idx,"-",ground_truth_label,"\t",detected_label,"\t",c_error)
    print("word error:",total_w_error/len(inputs),"mean character error:",total_c_error/len(inputs))