
# ERCOT-Exploratory-Data-Analysis

This project is a time series analysis of ERCOT Energy Consumption throughout the years. I attempt to decompose and seperate out yearly, monthly, and daily trends in the ERCOT Energy market serving the state of Texas. As the state's population continues to grow, and as Summers are hitting new record temperatures, Texas' energy supply is coming under more strain than ever.

![Alt Text](https://github.com/A-Sarkar18/ERCOT-Exploratory-Data-Analysis/blob/main/figures/ERCOT%20Time%20Series%20MW%20Consumption.png)

Figure A. illustrates yearly seasonality as expected. We can also even begin to observe monthly seasonality within single years, peaking in summer and winter months, due to heating and cooling demand. The plot does demonstrate a steadily growing trend in energy consumption in recent years, with newer and higher peaks.

![Alt Text](https://github.com/A-Sarkar18/ERCOT-Exploratory-Data-Analysis/blob/main/figures/ERCOT%20MW%20Yearly%20Consumption.png)

By viewing MW consumption trends grouped by year over the months, we can confirm our expectations of Summer peaks in Texas, with another peak in Winter.

![Alt Text](https://github.com/A-Sarkar18/ERCOT-Exploratory-Data-Analysis/blob/main/figures/ERCOT%20MW%20Consumption%20Weekly.png)

This plot in Figure C. enables us to capture the monthly time trends as well as daily trends. We see how energy consumption changes throughout the week for all months. 

![Alt Text](https://github.com/A-Sarkar18/ERCOT-Exploratory-Data-Analysis/blob/main/figures/ERCOT%20MW%20Consumption%20Daily.png)

In Figure D., can observe a relative peak in the middle of the day (from 10 am to 2 pm) after a steep ramping, then a relative minima (from 2 pm to 6 pm) and another peak (from 6 pm to 8 pm). This plot also shows the difference in consumptions from weekends and other days.

![Alt Text](https://github.com/A-Sarkar18/ERCOT-Exploratory-Data-Analysis/blob/main/figures/ERCOT%20MW%20Consumption%20Distribution.png)

This plot simply illustrates a gaussian-like distribution of consumption (MW) with a slight right skew and large right tail.

![Alt Text](https://github.com/A-Sarkar18/ERCOT-Exploratory-Data-Analysis/blob/main/figures/ERCOT%20MW%20Consumption%20Monthly%20Distribution.png)

This plot is interesting, since we can observe how summers seem to be experiecing higher and higher energy consumption demand from year to year (months 5-7).

![Alt Text](https://github.com/A-Sarkar18/ERCOT-Exploratory-Data-Analysis/blob/main/figures/ERCOT%20MW%20Consumption%20Daily%20Distribution.png.png)

This is also a fairly straightforward plot that simply shows how the difference in energy consumption during the weekend compared to weekdays.

![Alt Text](https://github.com/A-Sarkar18/ERCOT-Exploratory-Data-Analysis/blob/main/figures/ERCOT%20MW%20Consumption%20Hourly%20Distribution.png.png)

This plot is insightful, since not only does it show us what we may have expected with regards to daily seasonailty, but also indicates, via the large amount of outliers, that the data is influenced by exogneous factors such as temperature or humidity. This results in extreme values that daily seasonality itself does not capture.

Here, I explore both types of decompsition; Additive & Multiplicative. 

Addititive:
y_t = S_t + T_t + R_t

Multiplicative:
y_t = S_t x T_t x R_t

S_t: Seasonal Component

T_t: Trend Cycle

R_t: Remainder

By seperating out the seasonality, we can gain a better sense of the behavior of the data overall for the entire year of 2020.
In the second plot for just the Month of December, we can even observe daily seasonal trends in energy consumption as well.

##2020

![Alt Text](https://github.com/A-Sarkar18/ERCOT-Exploratory-Data-Analysis/blob/main/figures/ERCOT%20MW%20Consumption%20Additive%20Decomposition%202020.png)

![Alt Text](https://github.com/A-Sarkar18/ERCOT-Exploratory-Data-Analysis/blob/main/figures/ERCOT%20MW%20Consumption%20Multiplicative%20Decomposition%202020.png)

##March 2020

![Alt Text](https://github.com/A-Sarkar18/ERCOT-Exploratory-Data-Analysis/blob/main/figures/ERCOT%20MW%20Consumption%20Additive%20Decomposition%20Mar%202020.png
)

![Alt Text](https://github.com/A-Sarkar18/ERCOT-Exploratory-Data-Analysis/blob/main/figures/ERCOT%20MW%20Consumption%20Multiplicative%20Decomposition%20Mar%202020.png
)
