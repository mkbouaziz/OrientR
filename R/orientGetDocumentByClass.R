#' @rdname orientGetDocumentByClass
#' @export
#'
#' @title
#' Retive a document from orientdb
#'
#' @description
#' \code{orientGetDocumentByClass} retrieves a document form orient
#'
#' @author
#' Mohamed Karim Bouaziz \email{mohamed.karim.bouaziz@gmail.com}
#'
#' @seealso \code{\link{orientConnect}}, \code{\link{orientDataBases}}, \code{\link{orientDataBaseDetail}}
#'
#' @param orient An element created with \code{orientConnect}.
#'
#' @param database The database to be used for retrieving a document.
#' 
#' @param recordPosition recordPosition of your orient node e.g. a node has the id #12:5 where 12 is your classid
#'  and 5 is your recordPosition
#' 
#'
orientGetDocumentByClass<-
  function(orient, database,className,recordPosition, ...) {
    request<-paste("http:/", orient, "documentbyclass", database,className,recordPosition, sep = "/")
    response <- getURL(request, .mapUnicode = FALSE)
    if(!int0(grep(pattern = "was not found",response,ignore.case = T))) { NA
    } else if(!int0(grep(pattern = "invalid class",response,ignore.case = T))){ NA

    }else{
    results <- fromJSON(response, ...)
    results<-as.data.frame(results)
    names(results)<-sub("^X\\.","",names(results))
    results
    }
  }

