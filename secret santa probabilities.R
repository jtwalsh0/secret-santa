##############################
##  SECRET SANTA PROGRAM   
##
##  Joe Walsh
##  Determine the probability of drawing each participant
##  Assign secret santas
##  Email the assignments
##  
##############################


## LOAD PARTICIPANT DATA
## This should be a CSV file with participant names in the first
## column, participant email addresses in the second column, and
## the names of people the participant cannot get separated by a
## comma in the third column.  For example,
##
## "names","email.addresses","prohibited"
## "Mike R.","mike.r.email@gmail.com",,
## "Mike W.","mike.w.email@yahoo.com","Amy,John"
## "Amy","amy.email@gmail.com","Mike W."
## "John","john.email@yahoo.com","Mike W."
## "Emily","emily.email@yahoo.com",,
##
## Be sure to use unique names.  

participants <- read.csv("secret santa participants.csv", header=TRUE)

# number of participants
k <- nrow(participants)  



## I originally wrote this program to determine the 
## probability of me drawing a certain person.  I 
## determined these probabilities by doing n simulations.
## This matrix also provides a check on whether prohibited
## assignments were made.

n <- 10000  # number of simulations


# matrix to store the results
data <- matrix(0, n, k)  
  colnames(data) <- names

  # Each row is a simulation, and each column is a participant.
  # The value in each cell is the participant's assignment in
  # that simulation.  For example, if the value in row 1, 
  # column 1 is 3, then the first participant will give a gift
  # to the third participant in the first simulation.
  #
  # Some people cannot draw some other people (e.g. spouses).
  # To avoid that problem, I randomly assign recipients again
  # and again until none of those rules are violated.

  for(i in 1:n){
    
    violation <- 1
    
    while(violation>0){
      draw <- sample(1:k, replace=FALSE)  # random sampling
      data[i,] <- names[draw]   # assign recipients

      
      t <- data.frame(data[i,], participants[,3])
        colnames(t) <- c("assigned","prohibited")
      
      # Number of self assignments
      number.violations <- sum(mapply(grepl, t[,1], rownames(t)))
      
      # Add how many other prohibitions there are
      number.violations <- number.violations + sum(mapply(grepl, t[,1], t[,2]))
      
      if(number.violations==0) violation <- 0
    }
    
  }



## MATRIX TO STORE PROBABILITIES
whodrawswho <- matrix(NA, k, k)
  rownames(whodrawswho) <- names
  colnames(whodrawswho) <- names

  for(j in 1:k){	# columns, for gifter
    for(i in 1:k){	#rows, for giftee
      #i=1; j=1
      #colnames(data)[i]
      whodrawswho[i,j] <- mean(data[,j]==colnames(data)[i])
    }
  }

round(whodrawswho,2)  # print matrix with rounded values




## BE SAFE: RECORD THE ASSIGNMENTS
## We make the actual assignments using the first simulation.

assignments <- matrix(NA, k, 2)
  colnames(assignments) <- c("gifter","giftee")

  assignments[,1] <- names 
  assignments[,2] <- data[1,]

write.csv(assignments,"secret santa assignments.csv")



## EMAIL THE ASSIGNMENTS
require(mail)  # R package to send emails

msg1 <- "Congratulations, "
msg2 <- "! You have drawn "
msg3 <- " in this years Secret Santa." 
msg4 <- "The spending limit is 25 dollars."

for(i in 1:k){
  sendmail(email.addresses[i], 
           subject='Secret Santa',
           message=paste(msg1, names[i], msg2, colnames(data)[data[1,i]], msg3, sep=''))
}
