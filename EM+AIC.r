#Get the data
#-------------------------------------------------------------------------------
data <- read.csv('faithful.csv')
hist(data$waiting)
data <- data$waiting


#------------------------------------------------------------------------------
#Get parameters
#-------------------------------------------------------------------------------
numofmodes<-2
error=0.00001
premu<-seq(from=min(data),to=max(data),by=(max(data)-min(data))/(numofmodes-1)) 
prepi<-rep(1/numofmodes,times=numofmodes)
presigma<-rep(1,times=numofmodes)
promu<-seq(from=min(data),to=max(data),by=(max(data)-min(data))/(numofmodes-1))
propi<-rep(1/numofmodes,times=numofmodes)
prosigma<-rep(1,times=numofmodes)
p=matrix(NA,nrow=length(data),ncol=numofmodes)
#likelihood<-sum(pi1*(log(pi1)+log(dnorm(dat,mu1,sigma1))))+sum(pi2*(log(pi2)+log(dnorm(dat,mu2,sigma2))))
loglik<-rep(1,times=10)
AIC=0
#------------------------------------------------------------------------------
#EM algorithm part
#-------------------------------------------------------------------------------
for(count in 1:10){
  sum=0
  for(i in 1:numofmodes){
    sum<-(prepi[i]*dnorm(data,premu[i],presigma[i])+sum)
  }
  a<-log(sum,base=exp(1))
  loglik[count]<-sum(a)
    AIC=2*(numofmodes*3)-log(sum(sum),base = exp(1))
  #  print(sumparameter)
  for (i in 1:numofmodes){
    p[,i]<-(prepi[i]*dnorm(data,premu[i],presigma[i]))/sum
    propi[i]<-mean(p[,i])
    promu[i]<-sum(p[,i]*data)/sum(p[,i])
    prosigma[i]<-sqrt(sum(p[,i]*(data-promu[i])^2)/sum(p[,i]))
  }
  #  print(prepi)
  #  print(premu)
  #  print(presigma)
  #  print(propi)
  #  print(promu)
  #  print(prosigma)
  #  print(promu-premu)
  #  print(mean(promu-premu))
  #  if((mean(promu-premu)>=0)&&(mean(propi-prepi)>=0)&&(mean(prosigma-presigma)>=0)&&(mean(promu-premu)<=error)&&(mean(propi-prepi)<=error)&&(mean(prosigma-presigma)<=error)){
  #    break
  #  }
  if((loglik[count]-loglik[count-1]<=error)&&(count>1)){
    break
  }
  else{
    prepi<-propi
    premu<-promu
    presigma<-prosigma
    #    for(i in 1:numofmodes){
    #      print(c('pi',i,':',prepi[i],'mu',i,':',premu[i],'sigma',i,':',presigma[i]))
    #    }
    print(prepi)
    print(premu)
    print(presigma)
    print (count)
    print(loglik[count])
    print(AIC)
  }
}
