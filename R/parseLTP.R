parseLTP = function(result)
{
    result = htmlTreeParse(result,useInternalNodes=T)
    r = xmlRoot(result)
    r = r[[1]][[1]]
    
    missions = xmlAttrs(r[[1]])=='y'
    ind = match(names(missions),
                c("sent","word","pos","ne","parser","wsd","srl"))
    missions = missions[ind]
    
    if (!missions[1])
    {
        cat('Mission Unfinished!\n')
        return(doc(tags=missions));
    }
    
    para_xml = xmlToList(r[[2]])#doc tag
    sents = list()
    
    for (p_ind in 1:length(para_xml))
    {
        p = para_xml[[p_ind]]
        sent_xml = p[-length(p)]
        p_attr = p$.attrs
        
        for (s_ind in 1:length(sent_xml))
        {
            s = sent_xml[[s_ind]]
            word_xml = s[-length(s)]
            s_attr = s$.attrs
            n = length(word_xml)
            terms = data.frame(id = 1:n,
                               cont = rep('',n),
                               pos = rep('',n),
                               ne = rep('',n),
                               parent = rep(-1,n),
                               relate = rep('',n),
                               wsd = rep('',n),
                               wsdexp = rep('',n),
                               hasargs = rep(FALSE,n))
            args = vector(n,mode='list')
            
            for (w_ind in 1:n)
            {
                w = word_xml[[w_ind]]
                
                if (is.list(w))
                {
                    w_attr = w$.attrs
                    arg = w[-length(w)]
                    arg = do.call(rbind,arg)
                    rownames(arg)=NULL
                    arg = as.data.frame(arg)
                    arg[,1] = as.numeric(arg[,1])+1
                    arg[,3] = as.numeric(arg[,3])+1
                    arg[,4] = as.numeric(arg[,4])+1
                    args[[w_ind]] = arg
                    terms[['hasargs']][w_ind] = TRUE
                }
                else
                    w_attr = w
                
                terms$cont[w_ind] = w_attr['cont']
                if (length(w_attr)>2)
                {
                    w_attr = w_attr[-(1:2)]
                    n_attr = names(w_attr)
                    for (wa_ind in 1:length(w_attr))
                        terms[[n_attr[wa_ind]]][w_ind] = w_attr[wa_ind]
                }
            }
            
            terms$parent = as.numeric(terms$parent)+1
            
            s_cont = s_attr['cont']
            sents = c(sents,sent(id=s_ind,
                                 para_id=p_ind,
                                 cont=s_cont,
                                 terms=terms,
                                 args=args))
        }
    }
    ans = doc(tags=missions,sents=sents)
    ans
}