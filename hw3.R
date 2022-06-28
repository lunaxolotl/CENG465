library(Rpdb)
options(max.print = 5000)
args = commandArgs(trailingOnly=TRUE)
aminoacid = read.pdb(args[1])
aaatoms = aminoacid$atoms
atom = subset(aaatoms, recname == "ATOM", reindex.all = F) 
carbon = subset(atom, elename == "CA", reindex.all = F)
S = as.integer(args[3]) ## should be integer 
D = as.double(args[2]) ## should be float
rows = nrow(carbon)
for (i in 1:rows){
  for (j in i:rows){
    a = carbon[i,]
    b = carbon[j,]
    if (S <= abs(b$resid-a$resid)){
      d = sqrt((a$x1-b$x1)^2 + (a$x2-b$x2)^2 + (a$x3-b$x3)^2)
      if (d <= D){
        if (a$chainid == b$chainid){
          cat("Chain: ",a$chainid," --> ", a$resname, "(", a$resid,") - ", b$resname, "(", b$resid, ") : ", round(d,digits = 3)," Angstorms", '\n', sep = "")
        }
      } 
    }
  }
}







  