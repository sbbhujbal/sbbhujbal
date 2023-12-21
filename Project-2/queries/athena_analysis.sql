/* select all */
SELECT * 
FROM "sundb"."sb_nutrition" ;
/* count of beverages in starbucks */
SELECT count(beverage) as count_of_beverages FROM "sundb"."sb_nutrition" limit 10;
/* count of zero calorie beverage */
SELECT count(beverage) as count_of_beverages 
FROM "sundb"."sb_nutrition"
WHERE calories = 0 ;
/* Name of beverages which has zero calories*/
SELECT beverage_category,beverage 
FROM "sundb"."sb_nutrition"
WHERE calories = 0 ;
/* Beverages with High carbohydrates more than 100g */
SELECT beverage_category,beverage, beverage_prep , total_carbohydrates_g
FROM "sundb"."sb_nutrition"
WHERE total_carbohydrates_g > 100 ;
/* Beverages with protein_g more than 10g */
SELECT beverage_category,beverage, beverage_prep , protein_g
FROM "sundb"."sb_nutrition"
WHERE protein_g > 10 ;
/* Beverages with sugars_g more than 50g */
SELECT beverage_category,beverage, beverage_prep , sugars_g
FROM "sundb"."sb_nutrition"
WHERE sugars_g > 50 ;