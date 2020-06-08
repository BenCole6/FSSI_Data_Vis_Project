require(pacman)

p_load(ggplot2,
       tidyverse,
       forecast,
       gridExtra)

AirPassengers_df <- tibble(Passengers = AirPassengers,
                           Date = as.numeric(time(AirPassengers)))

lm_AirPassengers <- lm(Passengers ~ Date,
                       AirPassengers_df)

(gg_AirPassengers <- ggplot(AirPassengers_df,
                            aes(x = Date,
                                y = Passengers)) +
    geom_abline(intercept = lm_AirPassengers$coefficients[1],
                slope = lm_AirPassengers$coefficients[2],
                col = "grey",
                linetype = 5) +
    geom_line(col = "purple",
              size = 1.5) +
    ggtitle("Time Series Example") +
    scale_y_continuous(limits = c(0, NA)) +
    theme_minimal())

plot(forecast(AirPassengers))

Extrapolation <- sample_n(AirPassengers_df, 4)

lm_Extrapolation <- lm(Passengers ~ Date,
                       Extrapolation)

(gg_Extrapolation <- ggplot(Extrapolation,
                            aes(x = Date,
                                y = Passengers)) +
    geom_abline(intercept = lm_Extrapolation$coefficients[1],
                slope = lm_Extrapolation$coefficients[2],
                col = "grey", linetype = 5) +
    geom_line(col = "purple",
              size = 1.5) +
    geom_point(col = "purple",
               size = 2) +
    ggtitle("Extrapolation Example") +
    scale_y_continuous(limits = c(0, NA)) +
    theme_minimal())


grid.arrange(gg_AirPassengers, gg_Extrapolation)
