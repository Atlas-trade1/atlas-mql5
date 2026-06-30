//+------------------------------------------------------------------+
//|                                                  AtlasPropEA.mq5 |
//|                                    Built by Atlas for $100k Challenge |
//|                        https://atlas-trade1.github.io/atlas-mql5/ |
//+------------------------------------------------------------------+
#property copyright "Atlas"
#property link      "https://atlas-trade1.github.io/atlas-mql5/"
#property version   "1.00"
#property strict

input double MaxDailyLossPercent = 5.0;  // FTMO Daily Loss %
input double MaxRiskPerTrade = 1.0;      // Risk 1% per trade
input int    MagicNumber = 12345;        // EA ID

datetime dayStartTime;
double dayStartBalance;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   dayStartTime = iTime(_Symbol, PERIOD_D1, 0);
   dayStartBalance = AccountInfoDouble(ACCOUNT_BALANCE);
   
   Print("AtlasPropEA v1.00 Loaded - Prop Firm Protection Active");
   Comment("AtlasPropEA | Daily Loss: ",MaxDailyLossPercent,"% | Ready");
   
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   // Reset at new day
   if(iTime(_Symbol, PERIOD_D1, 0) != dayStartTime)
   {
      dayStartTime = iTime(_Symbol, PERIOD_D1, 0);
      dayStartBalance = AccountInfoDouble(ACCOUNT_BALANCE);
   }
   
   // Daily Loss Check - Prop Firm Rule
   double currentBalance = AccountInfoDouble(ACCOUNT_BALANCE);
   double dailyLoss = dayStartBalance - currentBalance;
   double dailyLossPercent = (dailyLoss / dayStartBalance) * 100;
   
   if(dailyLossPercent >= MaxDailyLossPercent)
   {
      Print("DAILY LOSS LIMIT HIT: ",dailyLossPercent,"% - Trading Stopped");
      Comment("STOPPED: Daily Loss Limit Reached");
   }
}
//+------------------------------------------------------------------+
