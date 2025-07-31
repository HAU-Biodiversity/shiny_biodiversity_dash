library(sf)

shapes <- st_read("data/shp_files/RPA/Copy_of_rpa_land_parcels_49c15-fc46cf.shp")




# st_crs(shapes)
shapes_wgs84 <- st_transform(shapes, crs = 4326)
saveRDS(shapes_wgs84, "data/shp_files/RPA/landPaecels.rds")

# names(shapes_wgs84)
