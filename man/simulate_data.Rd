% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/util.R
\name{simulate_data}
\alias{simulate_data}
\title{Simulates data with sample data structure from which the yield can be estimated}
\usage{
simulate_data(
  max_qDate = 12,
  periods = 36,
  bond_multiplier = 2,
  coupon_frequency = 3,
  coupon_rates = 1:5,
  sdev = 0.1,
  arma_terms = list(ar = 0.1, ma = 0),
  yield = NULL
)
}
\arguments{
\item{max_qDate}{An integer giving the number of quotation dates to use in the data. Defaults to 12.}

\item{periods}{An integer giving the maximum number of time to maturity periods the yield curve is estimated for each quotation date. Defaults to 36}

\item{bond_multiplier}{An integer giving the number of bonds to simulate for each day in the data.
Total bonds equals multiplier * (periods + max_qdate). Defaults to 2}

\item{coupon_frequency}{Integer, frequency of coupon payments. Defaults to 3}

\item{coupon_rates}{Vector, allowed coupon rates in percentage, each bond will have a coupon randomly drawn from this vector. Defaults to c(1, 2, 3, 4, 5)}

\item{sdev}{Standard deviation of the price errors, which is scaled by the square root of time to maturity so long term bonds have a larger error.
Defaults to 0.1}

\item{arma_terms}{List of ar and ma parameters passed to \code{arima.sim} to add error dependency. Defaults to list(ar= 0.1, ma = 0). See \code{?stats::arima.sim}.}

\item{yield}{Matrix of yield curves at different time to maturities from generate_yield().
If NULL, a yield matrix is created from the default values of \code{generate_yield()} with the values of \code{max_qDate} and \code{periods} input to \code{simulate_data()}.}
}
\value{
Data frame with the following columns. See also \code{Details}.
\describe{
   \item{qdate}{The quotation date, as an integer}
   \item{crspid}{Factor that uniquely identifies the bond}
   \item{mid.price}{The quoted price of the bond on that day}
   \item{tupq}{Time until a given payment, given in days}
   \item{pdint}{Numeric value of payment}
   \item{tumat}{Time until maturity, in days (equal to tupq for zero coupon bonds)}
   \item{accint}{The accumulated interest on payments}
}
}
\description{
Simulates data with the data structure that can be used in \code{estimate_yield}
}
\details{
The discount rate for each time to maturity and quotation date is calculated as
\deqn{Discount_{i, t} = \exp(-\tau_i * Yield_t)}
After getting the discount rate for each quotation date and time to maturity, bonds are simulated and priced, where the price of Bond \eqn{j} on quotation date \eqn{t} is given by
\deqn{Price_{t, j} = \sum_i payment_i Discount_{i, t}}
A small error is added to each price. The resulting data may be input into estimate_yield with suitable grid values. This is shown in the vignette
}
\examples{
data <- simulate_data()
}
