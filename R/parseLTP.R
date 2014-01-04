parseLTP = function(para_xml)
{
    para_len = length(para_xml)
    sent_xml = lapply(para_xml,function(x)x[-length(x)])
    sent_xml = unlist(sent_xml,recursive=F)
    
    sent_cont = lapply(sent_xml,function(x)x[[length(x)]])
    sent_cont = do.call(rbind,sent_cont)[,2]
    names(sent_cont) = NULL
    
    sent_xml = lapply(sent_xml,function(x)do.call(rbind,x[-length(x)]))
    sent_len = sapply(sent_xml,nrow)
    names(sent_len) = NULL
    sent_xml = do.call(rbind,sent_xml)
    sent_xml = sent_xml[,2]
    rownames(sent_xml) = NULL
    sent_id = rep(1:length(sent_len),sent_len)
    sent_dat = data.frame(sid = sent_id,words = sent_xml)
    rownames(sent_dat) = NULL
    
    sent_len = cumsum(sent_len)
    sent_begin = c(1,sent_len[-length(sent_len)]+1)
    sent_end = sent_len
    
    result = list(sent_dat,sent_cont,sent_begin,sent_end)
    return(result)
}