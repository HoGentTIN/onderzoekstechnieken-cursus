sigmoide <- function (alfa, beta, x){
  z <- alfa + beta * x;
  e <- exp(z);
  return(e/(1+e));
}