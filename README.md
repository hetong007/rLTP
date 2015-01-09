rLTP
====

An r package for ltp-cloud service. To get a valid **API_Key** please register on [ltp-cloud](http://www.ltp-cloud.com/) and visit [Dashboard](http://www.ltp-cloud.com/dashboard).

I borrowed some pieces of codes from [tmcn](https://r-forge.r-project.org/R/?group_id=1571) to do encoding conversion.

## Installation:

```{r}
require(devtools)
install_github('hetong007/rLTP')
```

Try the following example:

```r
ltp('我告诉你们，我是身经百战的，见得多啦，西方的哪一个国家我没有去过，你们也知道美国的华莱士，比你们不知高到哪里去，我跟他谈笑风生，只是媒体也要提高自己知识水平，识得唔识得呀！你们有一个好，全世界甚么地方，你们跑得最快，但是问来问去的问题呀，too simple，sometimes naive，识得唔识得？',api_key='YourAPIKey')
ltp('根据碳碳键键能能否否定定律一或定律二？',api_key='YourAPIKey')
```

LTP-Cloud now Also provides [official Sample R code](https://github.com/HIT-SCIR/ltp-cloud-api-tutorial/tree/master/R).
