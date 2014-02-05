library(Rhipe)
rhinit()
x <- list(1,2,3)
rhwrite(x,file="/tmp/x2",style='new')
rhread("/tmp/x2")

system("wget http://www.gutenberg.org/cache/epub/2701/pg2701.txt")
rhput("pg2701.txt", "/tmp/x/pg2701.txt")


map<-expression({ 
  words_vector<-unlist(strsplit(unlist(map.values)," ")) 
  lapply(words_vector,function(i) rhcollect(i,1)) 
}) 

reduce<-expression( 
  pre={total <- 0}, 
  reduce={total<-sum(total,unlist(reduce.values))}, 
  post={rhcollect(reduce.key,total)} 
)   

Job <- 
  rhwatch(map=map,reduce=reduce,jobname="word_count", input=rhfmt(folders="/tmp/x3/", type='text',nline="10")) 
#Wait for a while. Job Tracking Error in RHipe, but Job may be successful. 

x<-rhread("/tmp/x3/out") 
head(do.call("rbind",lapply(x,function(x) list(x[[1]],x[[2]])))) 
