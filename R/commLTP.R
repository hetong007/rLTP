getCom = function(input,mission='ws',user,pw='password')
{
    addr = "http://api.ltp-cloud.com:8080"
    uris = "/ltp_srv/ltp"
    server = paste(addr,uris,sep='')
    
    header = as.character(base64(paste(user,pw,sep=':')))
    header = paste('Basic',header)
    header = c('Authorization'=header)
    
    data = 'x=n&c=utf-8&t=all'
    data = paste(data,input,sep='&s=')
    data = URLencode(data)
    
    ans = postForm(uri = server,
                   .opts = curlOptions(httpHEAD=header),
                   style = "post",
                   'x' = 'n',
                   's' = input,
                   'c' = 'utf-8',
                   't' = mission)
    ans = rawToChar(ans)
    return(ans)
}

#require(tmcn)
#require(RCurl)
#require(XML)
#txt=readLines('~/github/WordSplit/wuxia/越女剑.txt')
#txt=toUTF8(txt)
#txt=gsub('\\s+','',txt)
#txt=paste(txt,collapse='')
#temp = getCom(txt,user='hetong007@gmail.com:ypcOZA6a')

