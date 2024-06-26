
# ERCOT-Exploratory-Data-Analysis

This project is a time series analysis of ERCOT Energy Consumption throughout the years. I attempt to decompose and seperate out yearly, monthly, and daily trends in the ERCOT Energy market serving the state of Texas. As the state's population continues to grow, and as Summers are hitting new record temperatures, Texas' energy supply is coming under more strain than ever.

Figure A. illustrates yearly seasonality as expected. We can also even begin to observe monthly seasonality within single years, peaking in summer and winter months, due to heating and cooling demand. The plot does demonstrate a steadily growing trend in energy consumption in recent years, with newer and higher peaks.

By viewing MW consumption trends grouped by year over the months, we can confirm our expectations of Summer peaks in Texas, with another peak in Winter.


This plot enables us to capture the monthly time trends as well as daily trends. We see how energy consumption changes throughout the week for all months. 

We can observe a relative peak in the middle of the day (from 10 am to 2 pm) after a steep ramping, then a relative minima (from 2 pm to 6 pm) and another peak (from 6 pm to 8 pm). This plot also shows the difference in consumptions from weekends and other days.


This plot simply illustrates a guassian-like distribution of consumption (MW) with a slight right skew and large right tail.


This plot is interesting, since we can observe how summers seem to be experiecing higher and higher energy consumption demand from year to year (months 5-7).

This is also a fairly straightforward plot that simply shows how thefference in energy consumption during the weekend.

This plot is insightful, since not only does it show us what we may have expected with regards to daily seasonailty, but also indicates, via the large amount of outliers, that the data is influenced by exogneous factors such as temperature or humidity. This results in extreme values that daily seasonality iyself does not capture.

Here, I explore both types of decompsition; Additive & Multiplicative. 

Addititive:
y_t = S_t + T_t + R_t

Multiplicative:
y_t = S_t x T_t x R_t

S_t: Seasonal Component
T_t: Trend Cycle
R_t: Remainder

By seperating out the seasonality, we can gain a better sense of the behavior of the data overall.
In the second plot for just the Month of December, we can even observe daily seasonal trends in energy consumption as well.



# Plot with colors
plot(result_add, col = "blue")
plot(result_mul, col = "red")

```

