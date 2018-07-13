fh <- file("../tangram/R/render-latex-map.R")
lines <- readLines(fh)
out <- "draft-unicode-test.txt"

cat('---\ntitle: "RViews on Tables"\nauthor: "Shawn Garbett"\ndate: "July 9, 2018"\noutput:\n  pdf_document: null\nheader-includes:\n\n- \\usepackage{float}\n- \\usepackage[x11names,dvipsnames,table]{xcolor}\n---\n\n\n```{r setup, include=FALSE}\nknitr::opts_chunk$set(echo = FALSE)\nlibrary(tangram)\n```\n',
    file=out)

for(line in lines)
{
  matches <- as.numeric(gregexpr("(\\\\[uU][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F])", line)[[1]])
  for(j in matches)
  {
    if(j > 0) {
      char <- substr(line, j, j+5)
      cat('Working on', substr(line, j+1, j+5),'\n\n', file=out, append=TRUE)
      cat('```{r, results="asis"}\n', file=out, append=TRUE)
      cat('l("', char, '")\n', sep='', file=out, append=TRUE)
      cat('```\n\n', file=out, append=TRUE)
    }
  }
}
close(fh)


