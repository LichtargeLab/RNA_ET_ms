

This code repository accompanies the manuscript

	*An Evolutionary Trace method defines functionally
	important bases and sites common to RNA families*

/work in progress/

There are two component of interest

1. ET program (ET_RNA_ms/et_bin/wetc)
	stand-alone C binary that produces ET ranking given a MSF alignment
	should run on any system with a compatible compiler		
			
	To run:
	1) In terminal, navigate to ET_RNA_ms/et_bin/
	2) Ensure the program runs by typing "./wetc - help"
	3) To score an RNA aligment, type
	
		./wetc -p [aln_path] -x [query_seq_name] -dnaet -realval -o [output_name]

		-p 		path to MSF alignment
		-x 		name of the query sequence as it appears in the alignment
		-dnaet		flag to enable non-protein scoring
		-realval	flag to run rvET scoring
		-o		base name for output files (can direct into dir '-o dir_path/basename')

2. Ribosome Example (ET_RNA_ms/ribosome_example)
	example of ET application using the 16S rRNA alignment,
	including the ET trace, and z-score computations
	uses wetc to produce ranking, but wrapped in MATLAB otherwise

	To run:
	1) Launch matlab
	2) Navigate in matlab console to ET_RNA_ms/ribosome_example
	3) Type 'ls' (no quotes) to examine contents of folder, there are 3 scripts of interest
		trace_alignment.m			traces the 16S alignment
		measure_et_structural_clustering	calculates ET clustering in the 16S structure
		measure_et_prediction_accuracy		calculates ET overlap with know functional sites in 16S
	4) Execute these 3 scripts in order
	5) Results and plots will be in the results/ and visualizaion/ folders

