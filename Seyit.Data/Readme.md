
* Extra transaction açmak gerekmeyeceği düşünülerek implemente edilmedi
* ComboDto : select option modeline verilen isim
* ListDto : tablo halinde gösterim modeline verilen isim
* DetailDto : detay grünüm modeline verilen isim

#inputs
    @RegionLetter nvarchar(5),
    @NewAirwayId uniqueidentifier
     
#generated
    @AirwayName nvarchar(max) 
    @LastAirwayScopeId  bigint
    @AccountPath nvarchar(100) 
    @TempAccountPath  nvarchar(100)  
    @ParentAirwayId bigint
    @CurrencyId int
    @CurrencyName nvarchar(3)
    
