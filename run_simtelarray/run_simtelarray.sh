#!/bin/bash

function printHelp {
    echo " --> ERROR in input arguments "
    echo " [0] -install                  : install sim_telarray"
    echo " [0] -test_sim_telarray        : test sim_telarray"
    echo " [0] -simple_test_sim_telarray : simple test sim_telarray"
    echo " [0] -h                        : print help"
}

#
sim_telarray_dir="/simtelarray/"
cfg_dir="/run_simtelarray/cfg/"
#
in_corsika_file="/store/cta/cta03/corsika_data/gamma/corsika_run307.corsika.gz"
out_simtel_file="/store/cta/cta03/simtel_data/gamma/data/corsika_run307.simtel.gz"
out_hist_file="/store/cta/cta03/simtel_data/gamma/hdata/corsika_run307.hdata"
out_log_file="/store/cta/cta03/simtel_data/gamma/log/corsika_run307.log"
#

if [ $# -eq 0 ] 
then    
    printHelp
else
    if [ "$1" = "-install" ]; then
	time ./build_all prod5-lp-sc-baseline qgs2
    elif [ "$1" = "-simple_test_sim_telarray" ]; then
	$sim_telarray_dir/sim_telarray/bin/sim_telarray | tee simple_test_sim_telarray.log
    elif [ "$1" = "-test_sim_telarray" ]; then
	echo "-test_sim_telarray"
	#
	rm -rf $out_hist_file
	rm -rf $out_simtel_file
	rm -rf $out_log_file
	#
	$sim_telarray_dir/sim_telarray/bin/sim_telarray -I$cfg_dir -c $cfg_dir/CTA-PROD5-LaPalma-baseline_4LSTs_MAGIC.cfg -DNUM_TELESCOPES=1 -DNO_STEREO_TRIGGER=1 -C min_photons=0 -C min_photoelectrons=1 -C save_photons=3 -C only_triggered_telescopes=1 -C only_triggered_arrays=1 -C random_state=auto -C show=all -C maximum_telescopes=1 -C fadc_sum_bins=75 -C telescope_phi=180 -C telescope_zenith_angle=20 -C asum_threshold=8.25 -C trigger_current_limit=2000.0 -C nightsky_background=all:0.386 -C nsb_scaling_factor=1 -C dark_events=0 -C pedestal_events=0 -h $out_hist_file -o $out_simtel_file $in_corsika_file 2>&1 > $out_log_file
	#
	#echo "out_log_file ---> $out_log_file"
    elif [ "$1" = "-h" ]; then
        printHelp
    else
        printHelp
    fi
fi

#espeak "I have done"
