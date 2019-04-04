#!/bin/bash
# **********************************************************************************
# *                 RWJ.sh Compiles Java classes and launches JVM                  *
# *                    Coded by Igor Soudakevitch; www.igor.host                   *
# *              Distributed under the terms and conditions of the GPL             *
# **********************************************************************************
# ver.0.18 / Jan.24, 2016 /

#----------------- Just a reminder javac & JVM invocation -----------------------

#		javac -encoding UTF-8 -d /home/$USER/Garbage/classes/org/xlator/_main_class_.java
#  	java -cp /home/$USER/Garbage/classes.org.xlator._main_class_

# Resulting cp dir structure: /home/$USER/Garbage/classes/org/xlator

# Suppose we've got RunMe.java with a reference to ClassA, which is defined in
# ClassA.java located in the same dir. Both classes belong to the same package
# org.xlator, and are located in the _whatever_dir_/org/xlator.
# In this case run from _whatever_dir_:
#           javac ./org/xlator/RunMe.java     where ./ is actually redundant
#           java org.xlator.RunMe

# Source files should be UTF-8 encoded to correctly support Unicode output 
# ------------------ End of introductory comments --------------------------------- 

javafile=$1

#Installation
workdir="/home/$USER/"
mkdir $workdir/Try_Java                     2>/dev/null
mkdir $workdir/Try_Java/Garbage             2>/dev/null
mkdir $workdir/Try_Java/Garbage/classes     2>/dev/null
mkdir $workdir/Try_Java/tempa               2>/dev/null
mkdir $workdir/Try_Java/tempb               2>/dev/null
mkdir $workdir/Try_Java/org                 2>/dev/null
mkdir $workdir/Try_Java/org/xlator          2>/dev/null
cd    $workdir/Try_Java


if [ $# -eq 0 ]; then
	echo "No arguments provided"
	echo "Usage: ./rwj.sh org/xlator/MyClass.java"
    exit 1
fi

#     This is THE ONLY place to mutate settings; refer to 'RULES' below

				args="1234 1Z0-808 5678"
				packaged="ON"
				javac_d_switch_cp="./Garbage/classes"
				package_name="org/xlator/"
				pack_root_dir="$workdir/Try_Java"
				dos_pack_path="org/xlator"

				added_path1="tempa"
				added_path2="tempb"
				all_added=".:./$added_path1:./$added_path2"
				
				enc="-encoding UTF-8"
#				enc=
				enc_type="UTF-8"
#				enc_type=
#				Xlint=
				Xlint="-Xlint:unchecked"
				warn=
#				warn="-nowarn"
#				Xdiags=
				Xdiags="-Xdiags:verbose"
				add_cp=;$CLASSPATH
#				add_cp=
				removal="ON"
#				removal="OFF"

#                                 RULES:
#    Added paths must be present BELOW %pack_root_dir%, e.g.:
#    /home/$USER
#     |--- ..........
#     |--- Try_Java
#     |      |
#     |      |--- org
#     |      |     |--- xlator
#     |      |
#     |      |--- tempa
#     |      |--- tempb				
#     |--- ..........

# --- 'packaged' var defines whether the source files contain the package statements

# --- If packaged==NO then classes will be compiled and run according to
# --- the 'simple_process' section (i.e., within the current dir)

# --- If packaged==YES then the compiled classes will be placed inside
# --- the javac_d_switch_cp dir that is to be used with -d switch (ref.to javac -help)

if [ "$enc"="" ] 
then
	enc_flag="OFF"
else
	enc_flag="ON"
fi
if [ "$add_cp" = "" ]
then
	add_cp_flag="OFF"
else
	add_cp_flag="ON"
fi
if [ "$warn" = "" ]
then
	warn_flag="ON"
else
	warn_flag="OFF"
fi
if [ "$Xlint" = "" ]
then
	Xlint_flag="OFF"
else
	Xlint_flag="ON"
fi
if [ "$Xdiags" = "" ]
then
	Xdiags_flag="OFF"
else
	Xdiags_flag="ON"
fi

if [ "$packaged" = "OFF" ]
then
	#Run simply
	echo "" 
	echo "" 
	echo "------------------------------- FYI ----------------------------------- "
	echo ""
	echo "   args                          :  $args"
	echo "   main class package            :  void"
	echo "   package path                  :  void"
	echo "   referenced class package(s)   :  void"
	echo "   javac -d switch classpath     :  void"
	echo "   appended CLASSPATH env var    :  void"
	echo "   forced encoding               :  $enc_flag ($enc_type)"
	echo "   -Xlint:unchecked              :  $Xlint_flag"
	echo "   -Xdiags:verbose               :  $Xdiags_flag"
	echo "   warnings                      :  $warn_flag"
	echo "   *.class removal               :  $removal"
	echo ""
	pwd
	echo javac $enc $Xlint $Xdiags $javafile
	echo java -cp . ${javafile%.*} $args
	echo "-------------------- End of batch file messages -----------------------"
	echo ""
	echo ""
	echo ""
	javac $enc $Xlint $Xdiags $javafile
	java -cp . ${javafile%.*} $args
	if [ "$removal" = "ON" ]
	then 
		echo ""
		echo "******************************************************************************"
		echo "*   all classes in the current dir(s) will be removed now;  *"
		echo "******************************************************************************"
		echo ""
		find . -name "*.class" -type f -delete
	fi
else
	#Run packaged
	clear

	#    The following 'if' checks whether the specified dir exists
	#    because a special file named 'nul' is present in every dir.o
	#    And one more thing: the 'exist' test only checks for *files*;
	#    that's precisely why we have to use \nul
	
	if [ ! -d "$javac_d_switch_cp" ]
	then
	  	echo "*"
		echo "*"
		echo "*******************************************************"
		echo "*          Packaged mode is ON but"
		echo "*          Directry $javac_d_switch_cp doesn't exist"
		echo "*******************************************************"
		echo "*"
		echo "*"
		exit 1
	fi

	echo ""
	echo ""
	echo "------------------------------- FYI ----------------------------------- "
	echo ""
	echo "   args                          :  $args"
	echo "   main class package            :  $package_name"
	echo "   package path                  :  $pack_root_dir/$dos_pack_path"
	echo "   referenced class package(s)   :  $pack_root_dir/$added_path1;$pack_root_dir/$added_path2"
	echo "   javac -d switch classpath     :  $javac_d_switch_cp/$dos_pack_path"
	echo "   appended CLASSPATH env var    :  $add_cp_flag"
	echo "   forced encoding               :  $enc_flag ($enc_type)"
	echo "   -Xlint:unchecked              :  $Xlint_flag"
	echo "   -Xdiags:verbose               :  $Xdiags_flag"
	echo "   warnings                      :  $warn_flag"
	echo "   *.class removal               :  $removal"
	echo ""
	pwd
	echo javac $enc -cp $all_added$add_cp -d $javac_d_switch_cp $Xlint $Xdiags $1
	echo java -cp $javac_d_switch_cp$add_cp $package_name`basename ${1%.*}` $args
	echo "-------------------- End of batch file messages -----------------------"
	echo ""
	echo ""
	echo ""
	cd $pack_root_dir
	javac $enc -cp $all_added$add_cp -d $javac_d_switch_cp $Xlint $Xdiags $1
	java -cp $javac_d_switch_cp$add_cp $package_name`basename ${1%.*}` $args
	
	if [ "$removal" = "ON" ]
	then
		echo ""
	        echo "**************************** CLEANING UP ******************************"
        	echo "*   all classes in -d cp dir(s) will be removed now;  *"
        	echo "***********************************************************************"
        	echo ""


		find $javac_d_switch_cp/$dos_pack_path -name "*.class" -type f -delete
		if [ -f $javac_d_switch_cp/$added_path1/*.class ]
		then
			find $javac_d_switch_cp/$added_path1 -name "*.class" -type f -delete
		fi
		if [ -f $javac_d_switch_cp/$added_path2/*.class ] 
		then
			find $javac_d_switch_cp/$added_path2 -name "*.class" -type f -delete
		fi
	fi
fi

	

