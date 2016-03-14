library(httr)

# TODO: implement fetchPlan
# TODO: implement updateMethod for PUT requests e.g. ?updateMode=full|partial]
# http://<server>:[<port>]/document/<database>/<record-id>[/<fetchPlan>]


# TODO make it possible to submit rid via table or String
# TODO URL encode String
createDocumentUrl = function(orient, database, recordId = NULL) {
  url = paste("http:/", orient, "document", database, sep = "/")
  
  if(!is.null(recordId)) {
    url = paste(url, recordId, sep = "/")
  }
  
  url
}


#' @rdname orientCheckDocument
#' @export
#' @title
#' Check 


# HEAD
orientCheckDocument = function(orient, database, recordId) {
  url = createDocumentUrl(orient, database, recordId)
  result = httr::HEAD(url)
  result$status_code == 204
}

#' @rdname orientGetDocument
#' @export
#' @title
#' Get 


# GET
orientGetDocument = function(orient, database, recordId) {
  url = createDocumentUrl(orient, database, recordId)
  result = httr::GET(url)
  
  if (result$status_code != 200) {
    return(FALSE)
  }
  
  httr::content(result)
}

#' @rdname orientCreateDocument
#' @export
#' @title
#' POST 


# POST
# content as named list
# use 'content["@class"] = "Profile"' to specify class
orientCreateDocument = function(orient, database, content) {
  url = createDocumentUrl(orient, database)
  result = httr::POST(url, body=content, encode = "json")
  
  if (result$status_code != 201) {
    return(FALSE)
  }
  
  httr::content(result)
}

#' @rdname orientUpdateDocument
#' @export
#' @title
#' PUT 


# PUT
# content as named list
# use 'content["@class"] = "Profile"' to specify class
# use 'content["@version"] = X' to specfiy version to update. This prevent to update documents changed by other users (MVCC).
# TODO result is text because of response plaintext content
orientUpdateDocument = function(orient, database, recordId = NULL, content) {
  url = createDocumentUrl(orient, database, recordId)
  result = httr::PUT(url, body=content, encode = "json", accept_json())

  if (result$status_code != 200) {
    return(FALSE)
  }
  
  httr::content(result)
}

#' @rdname orientAppendDocument
#' @export
#' @title
#' Append 


# PATCH
# content as named list
# use 'content["@class"] = "Profile"' to specify class
# use 'content["@version"] = X' to specfiy version to update. This prevent to update documents changed by other users (MVCC).
# TODO result is text because of response plaintext content
orientAppendDocument = function(orient, database, recordId = NULL, content) {
  url = createDocumentUrl(orient, database, recordId)
  result = httr::PATCH(url, body=content, encode = "json", accept_json())
  
  if (result$status_code != 200) {
    return(FALSE)
  }
  
  result
}

#' @rdname orientDelteDocument
#' @export
#' @title
#' DELETE 


# DELETE
orientDeleteDocument = function(orient, database, recordId) {
  url = createDocumentUrl(orient, database, recordId)
  print(url)
  result = httr::DELETE(url)
  result$status_code == 204
}
