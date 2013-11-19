# Secret Santa Program

[Secret Santa](http://en.wikipedia.org/wiki/Secret_Santa)
> is a Western Christmas tradition in which members of a group or community are randomly assigned a person 
> to whom they anonymously give a gift. Often practiced in workplaces or amongst large families, participation 
> in it is usually voluntary. It offers a way for many people to give and receive a gift at low cost, since 
> the alternative gift tradition is for each person to buy gifts for every other person. In this way, the 
> Secret Santa tradition also encourages gift exchange groups whose members are not close enough to participate
> in the alternative tradition of giving presents to everyone else.

This software helps administer a Secret Santa exchange by performing three basic tasks:

<ol>
  <li>ASSIGN SECRET SANTAS: The program randomly pairs gifters with giftees and checks whether the user prohibited any of them (for example, the user might prohibit a husband getting his wife).  If any assignment is prohibited, the program repeats until all the assignments are acceptable.</li>
  <li>EMAIL EACH PARTICIPANT HER ASSIGNMENT: This program uses R's mail package, which sends a maximum of 20 emails a day.  See the mail documentation about disabling that limit.</li>
  <li>ESTIMATE THE PROBABILITY OF EACH SECRET SANTA PAIRING: The program uses simulation to estimate the probability of each pairing.  This not only informs the user about participant X's chances of drawing participant Y; it also provides a check that the program correctly understood the user's pairing prohibitions (for example, spouses cannot draw each other.)</li>
</ol>




## Participant Data

This program loads participant data (names; email addresses; and lists of prohibited assignees, such as spouses) from a user-created comma-separated file in the working directory with the name "secret santa participants.csv".  The file should have the following structure:

* Participant names in the first column
* Participant email addresses in the second column
* The names of people the participant cannot get separated by a comma in the third column  
* Variable names are "names", "email.addresses", and "prohibited".
 
Here is an example:

| names | email.addresses | prohibited |
|:---:|:---:|:---:|
| Mike R. | mike.r.email@gmail.com |  |
| Mike W. | mike.w.email@yahoo.com | Amy,John  |
| Amy | amy.email@gmail.com | Mike W. |
| John | john.email@yahoo.com | Mike W.  |
| Emily | emily.email@yahoo.com |  |


Be sure to use unique names.  




## Using R

I wrote the code in [R](http://www.r-project.org/), a free and widely-used statistics-oriented programming language.  There are several excellent references for R beginners:

* [Code School's free, interactive tutorial in R](http://www.codeschool.com/courses/try-r)
* [R in a Nutshell](http://web.udl.es/Biomath/Bioestadistica/R/Manuals/r_in_a_nutshell.pdf)
* A number of freely available "quick reference" sheets such as ones by [Tom Short](http://cran.r-project.org/doc/contrib/Short-refcard.pdf), and staff at the [University of Auckland](https://www.stat.auckland.ac.nz/~stat380/downloads/QuickReference.pdf)

This software relies on R's [mail](http://cran.r-project.org/web/packages/mail/index.html) package.  For more information on how to install this and other R packages, see [here](http://www.r-bloggers.com/installing-r-packages).
