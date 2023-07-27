# homeowners_and_neighborhoods


## Getting Started

This code has been tested on Mac desktop, IOS simulator, and an android physical device.

To input data, click enter data button on the app and paste the neighborhood and homeowner data into the field. Please ensure it follows the specified format below. This will create a file on the device and write your input to it.

If using IOS simulator, toggle hardware keyboard to input data (I/O -> Keyboard -> Connect hardware keyboard)



Data format:

The data should have one item (home buyer or neighborhood) per line.
Neighborhood lines start with 'N'. Neighborhood lines contain the scores of the characteristics of the
neighborhood in 'Key:Value' form. So, Belmont Acres might show up in the input file as:
N N1 E:10 W:1 R:5

Home buyer lines start with 'H'. Home buyer lines contain the goals of the home buyer coded the same as
for neighborhood. Home buyer lines also contain neighborhood preferences separated by a 'greater than'
symbol indicating that the neighborhood to the left is more preferred than the one to the right. So "AC
Capehart" is a high-goal home buyer that prefers Belmont Acres and might show up like this:
H H9 E:10 W:6 R:8 N1>N2>N3
