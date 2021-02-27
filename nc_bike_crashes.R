#This Snippet examines bike crash data in North Carolina, and looks at their location to major cities
setwd("C:/Users/Eric/Downloads")
data = read.csv("nc_bike_crash.csv", stringsAsFactors = TRUE, sep=";")
data = data[,-c(1,2)]


foo = data$Location
foo = as.character(foo)
foo  = strsplit(foo,",")
foo = unlist(foo)
loc = matrix(as.numeric(foo),nrow=nrow(data),byrow = TRUE)

# visualization
loc = data.frame(loc)
names(loc) = c("lat","long")
data1 = cbind(data,loc)

foo = subset(data1, lat>0)
xmin = min(foo$long)
xmax = max(foo$long)
ymin = min(foo$lat)
ymax = max(foo$lat)

cities = data.frame(City = c("Charlotte", "Raleigh", "Greensboro", "Durham", "Winston-Salem", "Fayetteville", "Cary", "Wilmington", "High Point", "Concord"),
                    Lat = c(35.2271, 35.7796, 36.0726, 35.9940, 36.0999, 35.0527, 35.7915, 34.2104, 35.9557, 35.4088 ), 
                    Long = c(-80.8431, -78.6382, -79.7920, -78.8986, -80.2442, -78.8784, -78.7811, -77.8868, -80.0053, -80.5795 ))

p = ggplot(data1, aes(x=long,y=lat), size = 3)
p + geom_point() + xlim(xmin,xmax) + ylim(ymin,ymax) + geom_point(data = cities, aes(x = Long, y = Lat, color = City) ,color = "cyan", size = 3)

p2 = ggplot(data1, aes(x= Bike_Injur,y=Bike_Age, fill=Bike_Injur))
p2+geom_boxplot()

p = ggplot(data1, aes(x= Drvr_Injur,y=Drvr_Age, fill=Drvr_Injur))
p+geom_boxplot()