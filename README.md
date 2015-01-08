rLTP
====

An r package for ltp-cloud service. To get a valid **API_Key** please register on [ltp-cloud](http://www.ltp-cloud.com/) and visit [Dashboard](http://www.ltp-cloud.com/dashboard).

Installation:

```{r}
install.packages("tmcn", repos="http://R-Forge.R-project.org")
require(devtools)
install_github('rLTP','hetong007')
```
We need `tmcn` for conversion from `GBK` to `UTF8`. 

Try the following example:

```r
ltp('我告诉你们，我是身经百战的，见得多啦，西方的哪一个国家我没有去过，你们也知道美国的华莱士，比你们不知高到哪里去，我跟他谈笑风生，只是媒体也要提高自己知识水平，识得唔识得呀！你们有一个好，全世界甚么地方，你们跑得最快，但是问来问去的问题呀，too simple，sometimes naive，识得唔识得？',api_key='YourAPIKey')
```

LTP-Cloud now Also provides [official Sample R code](https://github.com/HIT-SCIR/ltp-cloud-api-tutorial/tree/master/R).
