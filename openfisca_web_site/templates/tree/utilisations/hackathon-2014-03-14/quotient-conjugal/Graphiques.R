setwd("/home/lucie/Choses que je fais dans la vie/Hackaton openfisca")

nlev <- 10

#n est le nombre de niveaux (A calibrer en fonction de l'allure voulue pour le graphique). 

declacommune <- read.table("imposition-commune.csv", header=TRUE, sep=";")
declaseparee <- read.table("imposition-separee.csv", header=TRUE, sep=";")
declacommleg <- read.table("imposition-commune-legislation.csv", header=TRUE, sep=";")


sali0 <- declaseparee[["sali0"]]
vsali0 <- sali0[0:250]
sali1 <- declaseparee[["sali1"]] 
Impsep <- declaseparee[["irpp"]]
Impcomm <- declacommune[["irpp"]]
Impcommleg <- declacommleg[["irpp"]]
indminsep <- which (Impsep < Impcommleg)
minimpsep <- Impcommleg
minimpsep[indminsep] <- Impsep[indminsep]

#Impcomm <- declacommune[["Impot comm"]]

nb <- 250

# Graphique 1

Diffimppourcent <- (Impcomm - Impsep)

Matrdiffimp <- matrix(nrow=250, ncol=250)

for(i in 1:nb) { 
  Matrdiffimp[,i] <- Diffimppourcent[(((i-1)*nb+1):(i*nb))] 
}

Courbeimp1 <- filled.contour(x = vsali0, y = vsali0, Matrdiffimp, nlevels=nlev, col=(rainbow(n=nlev, start=0, end=3/6)) , xlab="Revenu du premier conjoint", ylab="Revenu du second conjoint", main="Gain à l'imposition commune dans la législation actuelle")

# Graphique 2

Diffimppourcentleg <- (Impcommleg - Impsep)

Matrdiffimpleg <- matrix(nrow=250, ncol=250)

for(i in 1:nb) { 
  Matrdiffimpleg[,i] <- Diffimppourcentleg[(((i-1)*nb+1):(i*nb))] 
}

Courbeimp2 <- filled.contour(x = vsali0, y = vsali0, Matrdiffimpleg, nlevels=nlev, col=(rainbow(n=2*nlev, start=0, end=3/6)) , xlab="Revenu du premier conjoint", ylab="Revenu du second conjoint", main="Gain à l'imposition commune dans le nouveau système")


#Graphique 3

Diffminimpsep <- (Impsep - minimpsep)

Matrdiffimpsep <- matrix(nrow=250, ncol=250)

for(i in 1:nb) { 
  Matrdiffimpsep[,i] <- Diffminimpsep[(((i-1)*nb+1):(i*nb))] 
}

Courbeimp3 <- filled.contour(x = vsali0, y = vsali0, Matrdiffimpsep, nlevels=nlev, col=(rainbow(n=2*nlev, start=1/12, end=3/6)) , xlab="Revenu du premier conjoint", ylab="Revenu du second conjoint", main="Perdants-gagnants chez les concubins")

#Graphique 4

Diffminimpcomm <- (minimpsep - Impcomm)

Matrdiffimpcomm <- matrix(nrow=250, ncol=250)

for(i in 1:nb) { 
  Matrdiffimpcomm[,i] <- Diffminimpcomm[(((i-1)*nb+1):(i*nb))] 
}

Courbeimp4 <- filled.contour(x = vsali0, y = vsali0, Matrdiffimpcomm, nlevels=nlev, col=(rainbow(n=nlev, start=0, end=3/6)) , xlab="Revenu du premier conjoint", ylab="Revenu du second conjoint", main="Perdants-gagnants chez les mariés")



