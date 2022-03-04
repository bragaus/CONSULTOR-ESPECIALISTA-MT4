#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

input int TenkanSen = 9; //Tenkan-Sen
input int KijunSen = 26; //Kijun-Sen
input int SenkouSpanB = 52; //Senkou-Span-B

int OnInit()
  {
   
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {

   
  }

void OnTick()
  {
  
   //double chikouSpan = iIchimoku(_Symbol,PERIOD_CURRENT,TenkanSen,KijunSen,SenkouSpanB,MODE_CHIKOUSPAN,26);
  
   double tenkanSen = iIchimoku(_Symbol,PERIOD_CURRENT,TenkanSen,KijunSen,SenkouSpanB,MODE_TENKANSEN,1);
   double kijunSen = iIchimoku(_Symbol,PERIOD_CURRENT,TenkanSen,KijunSen,SenkouSpanB,MODE_KIJUNSEN,1);

   double senkouSpanA = iIchimoku(_Symbol,PERIOD_CURRENT,TenkanSen,KijunSen,SenkouSpanB,MODE_SENKOUSPANA,1);
   double senkouSpanB = iIchimoku(_Symbol,PERIOD_CURRENT,TenkanSen,KijunSen,SenkouSpanB,MODE_SENKOUSPANB,1);
   
   Print(tenkanSen," ",kijunSen," ",chikouSpan," ",senkouSpanA," ",senkouSpanB," ");
  }

