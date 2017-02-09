xquery version "3.0";

for $id in collection('../?select=*.xml')//@n/data(.)
order by $id
return ($id,'&#x0A;')
