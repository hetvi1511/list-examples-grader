CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

if [[ -f "./student-submission/ListExamples.java"]]
    then
        echo "File exists !"
else
    echo "File not found! Need the file"
    exit 1
fi

mkdir Tests
cp ./student-submission/ListExamples.java/ ./Tests
cp TestListExamples.java ./Tests
cd Tests

javac ListExamples.java TestListExamples.java

if [[ $? -eq 0]]
    then
        echo "Compile Success !"
else
    echo "Error ! Could not compile" > javac-error.txt 1>&2
    exit 1
fi

javac -cp "javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar" *.java
if [[ $? -eq 0]]
    then 
        echo "Compile success !"
else
    echo "Error ! Could not compile" > java-error.txt 1>&2
    exit 1
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples
if [[ $? -eq 0]]
    then 
        echo "Run success"
else
    echo "Error ! Could not run" > java-error.txt 1>&2
    exit 1
fi
