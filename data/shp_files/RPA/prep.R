library(sf)

shapes <- st_read("data/shp_files/RPA/Copy_of_rpa_land_parcels_49c15-fc46cf.shp")


# st_crs(shapes)
shapes_wgs84 <- st_transform(shapes, crs = 4326)
saveRDS(shapes_wgs84, "data/shp_files/RPA/landPaecels.rds")


shapes2 <- st_read("data/shp_files/HAU/HAU arable.shp")
shapes3 <- st_read("data/shp_files/HAU/HAU Woodland Parcels.shp")

shapes2_wgs84 <- st_transform(shapes2, crs = 4326)
shapes3_wgs84 <- st_transform(shapes3, crs = 4326)

saveRDS(shapes2_wgs84, "data/shp_files/HAU/arable_parcels.rds")
saveRDS(shapes3_wgs84, "data/shp_files/HAU/woodland_parcels.rds")
