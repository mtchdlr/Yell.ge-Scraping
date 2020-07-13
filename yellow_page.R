#scraping yell

library(rvest)
library(jsonlite)
library(stringr)
library(dplyr)
library(webdriver)
library(glue)

#writen on workshop

url="https://www.yell.ge/restaurants.php?lan=eng#y=Tbilisi"
driver=run_phantomjs()
session=Session$new(port=driver$port)
session$go(url)

pageWD=session$getSource()
read_html(pageWD)%>%html_nodes(xpath = '//a[@class="SR_name_ myfont"]')%>%html_text()
names(session)


#session$findElement('div#load_companies_a')
#pageWD=session$getSource()
nchar(pageWD)
session$findElement('div#load_companies_a')$isEnabled()

isFALSE(session$findElement('div#load_companies_a')$isEnabled())
session$findElement('div#load_companies_a')$isEnabled()


for(i in 1:2){
  if(session$findElement('div#load_companies_a')$isEnabled()==F){
    session$findElement('div#load_companies_a')$click()
    pageWD=session$getSource()
  } else {
    print("break")
  }
}

if(session$findElement('div#load_companies_a')$isEnabled()==T){
  session$findElement('div#load_companies_a')$click()
  pageWD=session$getSource()
} else {
  print("ola")
}

if(session$findElement('div#load_companies_a')$isEnabled()==T) {
  repeat(session$findElement('div#load_companies_a')$click())
}



while(session$findElement('div#load_companies_a')$isEnabled()){
  session$findElement('div#load_companies_a')$click()
  pageWD=session$getSource()
}
nchar(pageWD)


names(session$findElement('div#load_companies_a'))


for(i in 1:3){
  if(session$findEement('div#load_companies_a')$isEnabled()){
    session$findElement('div#load_companies_a')$click()
    pageWD=session$getSource()
  }
}

name=read_html(pageWD)%>%html_nodes(xpath = '//a[@class="SR_name_ myfont"]')%>%html_text()
address=read_html(pageWD)%>%html_nodes(css='div.SR_address_.slfont')%>%html_text()
cuisine=read_html(pageWD)%>%html_nodes(css='td>div.SR_cuisine_ ')%>%html_text()
table=read_html(pageWD)%>%html_nodes(css='div>table.SR_')%>%html_table(trim = T,fill=T)
table[[2]]


table1=data.frame(matrix(unlist(table), nrow=1232, byrow=T,),stringsAsFactors=FALSE)
names(table1)[names(table1) == "X3"]="all3"
table2=table1$all3
class(table2)
table3=as.data.frame(table2)
library(stringr)
table3$table2[2]

table3$table2=as.character(table3$table2)
table4=rbind(str_split(table3$table2, n=2,pattern = '('))
table4=as.data.frame(str_split(table3," "))

table5=data.frame(table3,do.call(rbind,str_split(table3$table2,"Cui")))
table6=gsub('\n','',table5$table2)
table6=as.data.frame(table6)
table6$table6[2]

table6$table6=as.character(table6$table6)

table7=data.frame(table6,do.call(rbind,str_split(table6$table6,"Cui")))

table8=data.frame(table7,do.call(rbind,str_split(table7$X2,"Price")))
?separate_rows
?str_detect


a=as.vector(!str_detect(table8$X1.1,pattern = "sine"))
View(a)

while(!str_detect(table8$X1.1,pattern = "sine")){
  gsub(table8$X1.1,replacement = '')
}
table8$X1.1=str_remove(table8$X1.1, pattern = "sine")
table8$X1.1=str_remove(table8$X1.1, pattern = ": ")
table8$X1.1=str_remove(table8$X1.1, pattern = "All objects")

table8$X1.1 = sub("Tbilisi\\.", "", table8$X1.1)
a=as.data.frame(cbind(name,address))
a$cuisine=table8$X1.1
write.csv(a,"a.csv")
