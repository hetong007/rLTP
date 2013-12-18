ltp = function(input=NULL,file=NULL,mission='ws',
               email='hetong007@gmail.com',token='ypcOZA6a')
{
    if (is.null(input) && is.null(file))
        stop('No Input.')
    ID = paste(email,token,sep=':')
    if (!is.null(file))
        input = readLines(file)
    if (!isUTF8(input[1]))
        input = toUTF8(input)
    input = gsub('\\s+','',input)
    input = input[input!='']
    if (length(input)==0)
        stop('Empty Input.')
    n = length(input)
    if (n==1)
        inputs = input
    else
    {
        nc = nchar(input[1])
        inputs = ''
        L = 1
        for (i in 2:n)
        {
            if (nchar(inputs[L])+nchar(input[i])<100000)
                inputs[L] = paste(inputs[L],input[i],sep='\n')
            else
            {
                L = L+1
                inputs[L] = input[i]
            }
        }
    }
    
    if (length(inputs)==1)
    {
        cat('Uploading\n')
        para = commLTP(inputs,mission=mission,ID)
        cat('Downloaded,Parsing\n')
        mission = para[[1]]
        sents = parseLTP(para[[2]])
    }
    else
    {
        cat('Uploading\n')
        paras = list()
        n = length(inputs)
        p = proc.time()
        for (i in 1:n)
        {
            paras[[i]] = commLTP(inputs[i],mission,ID)
            show(proc.time()-p)
            cat(paste(i,n,sep='/'),'\n')
            p = proc.time()
        }
        
        #paras = lapply(inputs,commLTP,mission,ID)
        cat('\nDownloaded,Parsing\n')
        missions = lapply(paras,function(x)x[[1]])
        missions = do.call(rbind,missions)
        n = ncol(missions)
        mission = rep(FALSE,n)
        for (i in 1:n)
            mission[i] = !any(!missions[,i])
        
        paras = lapply(paras,function(x)x[[2]])
        para = list()
        for (p in paras)
            para = c(para,p)
        sents = parseLTP(para)
    }
    ans = doc(tags=mission,sents=sents)
    ans
}
