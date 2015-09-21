function result=clustering(mass_height)
y=pdist(mass_height,'euclidean');
result=linkage(y,'median');
end