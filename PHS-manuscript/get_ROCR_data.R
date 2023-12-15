#The ROCR:performance creates an S4 object with the following slots (from ROCR package documentation): 
#- x.name Performance measure used for the x axis.
#- y.name Performance measure used for the y axis.
#- alpha.name Name of the unit that is used to create the parametrized curve. Currently, curves can only be parametrized by cutoff, so alpha.name is either none or cutoff.
#- x.values A list in which each entry contains the x values of the curve of this particular cross- validation run. x.values[[i]], y.values[[i]], and alpha.values[[i]] correspond to each other.
#- y.values A list in which each entry contains the y values of the curve of this particular cross- validation run.
#alpha.values A list in which each entry contains the cutoff values of the curve of this particular cross-validation run.

#get_ROCR_data() extracts all the data form ROCR object of class performance and returns a datafarame.

#helper function to extract a single measure with its name from the performance object
.get_var_from_performance_obj <- function(obj, v) {
  #get names of both slots for a var
  v_name <- paste0(v, ".name")
  v_values <- paste0(v, ".values")
  
  #gets variable name from the S4 object
  extracted_name <- slot(obj, v_name)
  extracted_name <- gsub(" ", "_", extracted_name) #replaces spaces with _
  
  #gets values from the S4 object
  extracted_values <- slot(obj, v_values)
  extracted_values <- unlist(extracted_values) #unlists them
  
  #creates df column
  df <- data.frame(extracted_values)
  names(df) <- extracted_name
  
  return(df)
}

#function to be used to extract all the values from the object (returns a df)
get_ROCR_data <- function(obj) {
  #make y.measure the first column
  df <- .get_var_from_performance_obj(obj, "y") #y is returned allways by default by performance()
  
  #extract x.measure if it was were requested 
  #if they were NOT, the list in x.values list is empty
  if (length(obj@x.values) != 0) {
    x <- .get_var_from_performance_obj(obj, "x")
    df <- cbind(df, x)
  }
  
  #extract alpha if provided 
  #if NOT provided, the list in alpha.values list is empty
  if (length(obj@alpha.values) != 0) {
    alpha <- .get_var_from_performance_obj(obj, "alpha")
    df <- cbind(df, alpha)
  }
  
  return(df)
}
