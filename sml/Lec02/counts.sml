
fun countup(from : int, to : int) = (* for testing our max functions *)
  if from = to
  then to :: []
  else from :: count(from+1, to)
fun countdown(from : int, to : int) = (* for testing our max functions *)
  if from = to
  then to :: []
  else from :: count(from-1, to)
