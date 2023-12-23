 drop table if exists public.sb_nutrition;
create table if not exists public.sb_nutrition (
    Beverage_category varchar(100),
	Beverage  varchar(255),
	Beverage_prep  varchar(100),
	Calories    integer, 
	Total_Fat_g     decimal(8,2),
	Trans_Fat_g 	decimal(8,2),
    Saturated_Fat_g decimal(8,2),
	Sodium_mg       integer,
	Total_Carbohydrates_g  integer, 
 	Cholesterol_mg  integer, 
	Dietary_Fibre_g integer, 
	Sugars_g decimal(8,2),
	Protein_g  decimal(8,2),
 	Vitamin_A_perdv decimal(8,4) ,
 	Vitamin_C_perdv decimal(8,4) ,
	Calcium_perdev decimal(8,4) ,
 	Iron_perdv decimal(8,4) ,
 	Caffeine_mg  varchar(100)
 ) ;