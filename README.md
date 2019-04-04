# Try_java
Linux alternative for windows utility rwj.bat ti test java exercises. https://www.amazon.com/dp/1548193984


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
