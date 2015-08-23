wrk <- tidy_final[order(tidy_final$subject_id, tidy_final$activity_code)]
mf <- data.frame()
mf <- cbind(1:83)
names(mf) <- names(tidy_final)
df <- mf[-c(2,4)]

for (i in 1:30)
{
  for (j in 1:6)
 {
      n <- c(i, j)
      for (k in 5:83)
      {
      n <- c(n, mean(wrk[,k][wrk$subject_id==i & wrk$activity_code==j])) 
      
      }
      
      
     df <- rbind(df, n, row.names.data.frame(""))
     
 }
  
  
}

##final data frame of mean values
df1 <- df[-c(1,2),]
