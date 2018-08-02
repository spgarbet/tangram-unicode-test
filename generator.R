gen <- function(prefix)
{
  for(i in c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"))
  {
    cat(paste0("Working on u",prefix,i,"\n\n"))
    cat(paste0("```{r, results='asis'}\n"))
    cat(paste0("l('\\u", prefix,i,"')\n"))
    cat("```\n\n")
  }
}

examine <- function(x)
{
  y <- as.character(x)                        # Make sure a character string was passed
  if(is.null(x) || nchar(y) == 0) return("")  # Abort early for zero characters

  ## Kludge for converting from "byte" to the current encoding
  ## in a way which preserves the hex notation.
  encBytes <- Encoding(y) == "bytes"
  if (any(encBytes)) y[encBytes] <- capture.output(cat(y[encBytes], sep = "\n"))

  ## Convert strings to UTF-8 encoding, NFD (decomposed) form, for
  ## processing of accented characters. Doing this early to
  ## circumvent pecularities in gsub() (and nchar()) when working in
  ## the C locale.
  y <- stri_trans_nfd(y)
  Encoding(y) <- "bytes"

  y
}
