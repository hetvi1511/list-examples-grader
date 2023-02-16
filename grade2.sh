CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -f ListExamples.java ]]
then
    echo "File with correct name ListExamples.java was submitted"
else
    echo "File ListExamples.java is needed"
    exit 1
fi

cp ../TestListExamples.java ./
cp ../lib ./
pwd

javac -cp ".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar" *.java 
# javac ListExamples.java 2>output.txt

if [[ $? == "0" ]]
    then
        echo "Compile Successful"
else
    echo "Error found"
    exit 1
    # cat output.txt
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > test-output.txt 2>runtime-error.txt
cat runtime-error.txt
cat test-output.txt