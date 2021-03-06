% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spreadr.R
\name{spreadr}
\alias{spreadr}
\title{Simulate spreading activation in a network}
\usage{
spreadr(
  network,
  start_run,
  retention = 0.5,
  time = 10,
  threshold_to_stop = NULL,
  decay = 0,
  suppress = 0,
  include_t0 = FALSE,
  create_names = TRUE,
  never_stop = FALSE
)
}
\arguments{
\item{network}{Adjacency matrix or
\code{\link[igraph:igraph-package]{igraph}} object representing the network
in which to simulate spreading activation.}

\item{start_run}{Non-empty \code{\link[base]{data.frame}} with mandatory
columns \emph{node}, \emph{activation}; and optional columns \emph{time}.
If the \emph{time} column is present, \emph{activation} is added to
\emph{node} at each \emph{time}. Otherwise, the \emph{activation}s are
added to their corresponding nodes at \code{t = 0}.}

\item{retention}{Number from 0 to 1 (inclusive) or a numeric vector of such
numbers of length equals number of nodes in the network. This represents
the proportion of activation that remains in the node (not spread) at each
time step. Then, \code{1 - retention} of the activation at each node is
spread to neighbouring nodes. If a numeric vector, retentions are assigned
to nodes according to the order given by \code{V(network)} if
\code{network} is an \code{\link[igraph:igraph-package]{igraph}} object or
\code{nrow(network)} if \code{network} is an adjacency matrix.}

\item{time}{Positive non-zero integer, or \code{NULL}. If not \code{NULL},
the number of time steps to simulate before stopping. Otherwise,
stop with the \code{threshold_to_stop} parameter.}

\item{threshold_to_stop}{Number or \code{NULL}. If not \code{NULL}, stop the
simulation only when all nodes have activation value less than
\code{threshold_to_stop}. Otherwise, stop with the \code{time} parameter.}

\item{decay}{Number from 0 to 1 (inclusive) representing the proportion of
activation that is lost at each time step.}

\item{suppress}{Number representing the maximum amount of activation in a
node for it to be set to 0, at each time step.}

\item{include_t0}{Boolean flag indicating if activation at \code{t = 0}
should be prepended to the output \code{data.frame}. This is \code{FALSE}
by default for back-compatibility.}

\item{create_names}{Boolean flag indicating if nodes should be automatically
named (\code{1:n}, where \code{n} is the number of nodes) in case they are
missing.}

\item{never_stop}{Boolean flag indicating if the simulation should be stopped
if there have been too many iterations (so that there might be an infinite
loop).}
}
\value{
A \code{\link[base]{data.frame}} with \emph{node}, \emph{activation}
  and \emph{time} columns representing the spread of activation in the network
  over time.
}
\description{
Simulate spreading activation in a network
}
\details{
At least one of parameters \code{time} or \code{threshold_to_stop}
  must be non-\code{NULL}. If both are non-\code{NULL}, the simulation stops
  at the earliest time possible.

  The simulation iterates like so: for every \code{i} in \code{[0, time]},
  \itemize{
    \item{Spread activation from node to node}
    \item{Decay the activation at each node by the proportion specified by
      \code{decay}}
    \item{Set the activation at nodes with activation less than
      \code{suppress} to \code{0}}
    \item{Add the activations in \code{start_run} with \code{time = i} to
      their corresponding nodes}
    \item{Save the activations at each node for output}
    \item{Check the terminating conditions \code{time} and
      \code{threshold_to_stop}. If any are satisfied, terminate the
      simulation.}
  }
}
\examples{
# make an adjacency matrix and randomly fill some cells with 1s
mat <- matrix(sample(c(0,1), 100, replace=TRUE), 10, 10)
diag(mat) <- 0 # remove self-loops
initial_df <- data.frame(node=1, activation=20, stringsAsFactors=FALSE)
results <- spreadr(mat, initial_df)

head(results, 10)
tail(results, 10)

}
