% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/liquidSVM.R
\name{trainSVMs}
\alias{trainSVMs}
\alias{train}
\title{Trains an SVM object.}
\usage{
trainSVMs(model, ..., solver = c("kernel.rule", "ls", "hinge", "quantile"),
  command.args = NULL, do.select = FALSE, useCells = FALSE, d = NULL)
}
\arguments{
\item{model}{the \code{svm}-model}

\item{...}{configuration parameters set before training}

\item{solver}{solver to use: one of "kernel.rule","ls","hinge","quantile","expectile"}

\item{command.args}{further arguments aranged in a list, corresponding to the arguments
of the command line interface to \code{svm-train}, e.g. \code{list(d=2,W=2)}
is equivalent to \code{svm-train -d 2 -W 2}.
See \link{command-args} for details.}

\item{do.select}{if not \code{FALSE} then the model is selected.
This parameter can be used as a list of named arguments to be passed to the select phase}

\item{useCells}{if \code{TRUE} partitions the problem (equivalent to \code{partition_choice=6})}

\item{d}{level of display information}
}
\value{
a table giving training and validation errors and more internal statistic
for every SVM that was trained.
This is also recorded in \code{model$train_errors}.
}
\description{
\strong{Should only be used by experts!}
This uses the \pkg{liquidSVM} C++ implementation to solve all SVMs on the hyper-parameter grid.
}
\details{
SVMs are solved for all tasks/cells/folds and entries in the hyper-parameter grid
and can afterwards be selected using \code{\link{selectSVMs}}.
A model even can be retrained using other parameters, reusing the training data.
The training phase is usually the most time-consuming phase,
and therefore for bigger problems it is recommended to use \code{display=1}
to get some progress information.

See \link{command-args} for details.
}
\section{Documentation for command-line parameters of svm-train}{

The following parameters can be used as well:
\itemize{
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{f=c(<kind>,<number>,[<train_fraction>],[<neg_fraction>])}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Selects the fold generation method and the number of folds. If <train_fraction>\cr
< 1.0, then the folds for training are generated from a subset with the\cr
specified size and the remaining samples are used for validation.\cr
Meaning of specific values:\cr
<kind> = 1  =>  each fold is a contiguous block\cr
<kind> = 2  =>  alternating fold assignmend\cr
<kind> = 3  =>  random\cr
<kind> = 4  =>  stratified random\cr
<kind> = 5  =>  random respecting group information of samples\cr
<kind> = 6  =>  random subset (<train_fraction> and <neg_fraction> required)\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<kind>:           integer between 1 and 6\cr
<number>:         integer >= 1\cr
<train_fraction>: float > 0.0 and <= 1.0\cr
<neg_fraction>:   float > 0.0 and < 1.0\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<kind>           = 3\cr
<number>         = 5\cr
<train_fraction> = 1.00\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{g=c(<size>,<min_gamma>,<max_gamma>,[<scale>])}\cr
\item \code{g=<gamma_list>}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
The first variant sets the size <size> of the gamma grid and its endpoints\cr
<min_gamma> and <max_gamma>.\cr
The second variant uses <gamma_list> for the gamma grid.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
<scale>       Flag indicating whether <min_gamma> and <max_gamma> are scaled\cr
based on the sample size, the dimension, and the diameter.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<size>:       integer >= 1\cr
<min_gamma>:  float > 0.0\cr
<max_gamma>:  float > 0.0\cr
<scale>:      bool\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<size>        = 10\cr
<min_gamma>   = 0.200\cr
<max_gamma>   = 5.000\cr
<scale>       = 1\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{GPU=c(<use_gpus>,[<GPU_offset>])}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Flag controlling whether the GPU support is used. If <use_gpus> = 1, then each\cr
CPU thread gets a thread on a GPU. In the case of multiple GPUs, these threads\cr
are uniformly distributed among the available GPUs. The optional <GPU_offset>\cr
is added to the CPU thread number before the GPU is added before distributing\cr
the threads to the GPUs. This makes it possible to avoid that two or more\cr
independent processes use the same GPU, if more than one GPU is available.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<use_gpus>:   bool\cr
<use_offset>: non-negative integer.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<gpus>       = 0\cr
<gpu_offset> = 0\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Unfortunately, this option is not activated for the binaries you are currently\cr
using. Install CUDA and recompile to activate this option.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{h=[<level>]}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Displays all help messages.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
<level> = 0  =>  short help messages\cr
<level> = 1  =>  detailed help messages\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<level>: 0 or 1\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<level> = 0\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{i=c(<cold>,<warm>)}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Selects the cold and warm start initialization methods of the solver. In\cr
general, this option should only be used in particular situations such as the\cr
implementation and testing of a new solver or when using the kernel cache.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
For values between 0 and 6, both <cold> and <warm> have the same meaning as\cr
in Steinwart et al, 'Training SVMs without offset', JMLR 2011. These are:\cr
0      Sets all coefficients to zero.\cr
1      Sets all coefficients to C.\cr
2      Uses the coefficients of the previous solution.\cr
3      Multiplies all coefficients by C_new/C_old.\cr
4      Multiplies all unbounded SVs by C_new/C_old.\cr
5      Multiplies all coefficients by C_old/C_new.\cr
6      Multiplies all unbounded SVs by C_old/C_new.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
Depends on the solver, but the range of <cold> is always a subset of the range\cr
of <warm>.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
Depending on the solver, the (hopefully) most efficient method is chosen.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{k=c(<type>,[aux-file],[<Tr_mm_Pr>,[<size_P>],<Tr_mm>,[<size>],<Va_mm_Pr>,<Va_mm>])}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Selects the type of kernel and optionally the memory model for the kernel matrices.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
<type>   = 0  =>   Gaussian RBF\cr
<type>   = 1  =>   Poisson\cr
<type>   = 3  =>   Experimental hierarchical Gauss kernel\cr
<aux_file>    =>   Name of the file that contains additional information for the\cr
hierarchical Gauss kernel. Only this kernel type requires this option.\cr
<X_mm_Y> = 0  =>   not contiguously stored matrix\cr
<X_mm_Y> = 1  =>   contiguously stored matrix\cr
<X_mm_Y> = 2  =>   cached matrix\cr
<X_mm_Y> = 3  =>   no matrix stored\cr
<size_Y>      =>   size of kernel cache in MB\cr
Here, X=Tr stands for the training matrix and X=Va for the validation matrix. In\cr
both cases, Y=Pr stands for the pre-kernel matrix, which stores the distances\cr
between the samples. If <Tr_mm_Pr> is set, then the other three flags <X_mm_Y>\cr
need to be set, too. The values <sizeY> must only be set if a cache is chosen.\cr
NOTICE: Not all possible combinations are allowed.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<type>:          integer between 0 and 3\cr
<X_mm_Y>:        integer between 0 and 3\cr
<size_Y>:        integer not smaller than 1\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<type>           = 0\cr
<X_mm_Y>         = 1\cr
<size_Y>         = 1024\cr
<size>           = 512\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{l=c(<size>,<min_lambda>,<max_lambda>,[<scale>])}\cr
\item \code{l=c(<lambda_list>,[<interpret_as_C>])}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
The first variant sets the size <size> of the lambda grid and its endpoints\cr
<min_lambda> and <max_lambda>.\cr
The second variant uses <lambda_list>, after ordering, for the lambda grid.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
<scale>             Flag indicating whether <min_lambda> is internally\cr
devided by the average number of samples per fold.\cr
<interpret_as_C>    Flag indicating whether the lambda list should be\cr
interpreted as a list of C values\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<size>:             integer >= 1\cr
<min_lambda>:       float > 0.0\cr
<max_lambda>:       float > 0.0\cr
<scale>:            bool\cr
<interpret_as_C>:   bool\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<size>              = 10\cr
<min_lambda>        = 0.001\cr
<max_lambda>        = 0.100\cr
<scale>             = 1\cr
<scale>             = 0\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{L=c(<loss>,[<clipp>],[<neg_weight>,<pos_weight>])}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Sets the loss that is used to compute empirical errors. The optional <clipp> value\cr
specifies where the predictions are clipped during validation. The optional weights\cr
can only be set if <loss> specifies a loss that has weights.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
<loss> = 0  =>   binary classification loss\cr
<loss> = 2  =>   least squares loss\cr
<loss> = 3  =>   weighted least squares loss\cr
<loss> = 4  =>   pinball loss\cr
<loss> = 5  =>   hinge loss\cr
<loss> = 6  =>   your own template loss\cr
<clipp> = -1.0  =>   clipp at smallest possible value (depends on labels)\cr
<clipp> =  0.0  =>   no clipping is applied\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<loss>:       values listed above\cr
<neg_weight>: float >= -1.0\cr
<neg_weight>: float > 0.0\cr
<pos_weight>: float > 0.0\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<loss>       = native loss of solver chosen by option -S\cr
<clipp>      = -1.000\cr
<neg_weight> = <weight1> set by option -W\cr
<pos_weight> = <weight2> set by option -W\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{P=c(1,[<size>])}\cr
\item \code{P=c(2,[<number>])}\cr
\item \code{P=c(3,[<radius>],[<subset_size>])}\cr
\item \code{P=c(4,[<size>],[<reduce>],[<subset_size>])}\cr
\item \code{P=c(5,[<size>],[<ignore_fraction>],[<subset_size>],[<covers>])}\cr
\item \code{P=c(6,[<size>],[<reduce>],[<subset_size>],[<covers>],[<shrink_factor>])}\cr
[<max_width>] [<max_depth>]\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Selects the working set partition method.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
<type> = 0  =>  do not split the working sets\cr
<type> = 1  =>  split the working sets in random chunks using maximum <size> of\cr
each chunk.\cr
Default values are:\cr
<size>            = 2000\cr
<type> = 2  =>  split the working sets in random chunks using <number> of\cr
chunks.\cr
Default values are:\cr
<size> = 10\cr
<type> = 3  =>  split the working sets into Voronoi subsets of radius <radius>.\cr
If [subset_size] is set, a subset of this size is used to faster\cr
create the Voronoi partition. If subset_size == 0, the entire\cr
data set is used, otherwise, the radius is only approximately\cr
ensured.\cr
Default values are:\cr
<radius>          = 1.000\cr
<subset_size>     = 0\cr
<type> = 4  =>  split the working sets into Voronoi subsets of maximal size\cr
<size>. The optional flag <reduce> controls whether a heuristic\cr
to reduce the number of cells is used. If [subset_size] is set,\cr
a subset of this size is used to faster create the Voronoi\cr
partition. If subset_size == 0, the entire data set is used, \cr
otherwise, the maximal size is only approximately ensured.\cr
Default values are:\cr
<size>            = 2000\cr
<reduce>          = 1\cr
<subset_size>     = 50000\cr
<type> = 5  =>  devide the working sets into overlapping regions of maximal\cr
size <size>. The process of creating regions is stopped when\cr
<size> * <ignore_fraction> samples have not been assigned to\cr
a region. These samples will then be assigned to the closest\cr
region. If <subset_size> is set, a subset of this size is\cr
used to find the regions. If subset_size == 0, the entire\cr
data set is used. Finally, <covers> controls the number of\cr
times the process of finding regions is repeated.\cr
Default values are:.\cr
<size>            = 2000\cr
<ignore_fraction> = 0.5\cr
<subset_size>     = 50000\cr
<covers>          = 1\cr
<type> = 6  =>  split the working sets into Voronoi subsets of maximal size\cr
<size>. The optional flag <reduce> controls whether a heuristic\cr
to reduce the number of cells is used. If [subset_size] is set,\cr
a subset of this size is used to faster create the Voronoi\cr
partition. If subset_size == 0, the entire data set is used, \cr
otherwise, the maximal size is only approximately ensured.\cr
Unlike for <type> = 4, the centers for the Voronoi partition are\cr
found by a recursive tree approach, which in many cases may be\cr
faster. <shrink_factor> describes by which factor the number of\cr
samples should at least be decreased. The recursion is stoppend\cr
when either <max_width> * <size> is greater than the current\cr
working subset or the <max_tree_depth> is reached. For both\cr
parameters, a value of 0 means that the corresponding condition\cr
above is ignored.\cr
Default values (so far, they are only a brave guess) are:\cr
<size>            = 2000\cr
<reduce>          = 1\cr
<subset_size>     = 50000\cr
<shrink_factor>   = 2.0000\cr
<max_width>       = 20\cr
<max_tree_depth>  = 4\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<type>:            integer between 0 and 6\cr
<size>:            positive integer\cr
<number>:          positive integer\cr
<radius>:          positive real\cr
<subset_size>:     non-negative integer\cr
<reduce>:          bool\cr
<covers>:          positive integer\cr
<shrink_factor>:   real > 1.0\cr
<max_width>:       non-negative integer\cr
<max_tree_depth>:  non-negative integer\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<type>             = 0\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{r=<seed>}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Initializes the random number generator with <seed>.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
<seed> = -1  =>  a random seed based on the internal timer is used\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<seed>: integer between -1 and 2147483647\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<seed> = -1\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{s=c(<clipp>,[<stop_eps>])}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Sets the value at which the loss is clipped in the solver to <value>. The\cr
optional parameter <stop_eps> sets the threshold in the stopping criterion\cr
of the solver.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
<clipp> = -1.0  =>   Depending on the solver type clipp either at the\cr
smallest possible value (depends on labels), or\cr
do not clipp.\cr
<clipp> = 0.0   =>   no clipping is applied\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<clipp>:    -1.0 or float >= 0.0.\cr
In addition, if <clipp> > 0.0, then <clipp> must not be smaller\cr
than the largest absolute value of the samples.\cr
<stop_eps>: float > 0.0\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<clipp>     = -1.0\cr
<stop_eps>  = 0.0010\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{S=c(<solver>,[<NNs>])}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Selects the SVM solver <solver> and the number <NNs> of nearest neighbors used\cr
in the working set selection strategy (2D-solvers only).\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
<solver> = 0  =>  kernel rule for classification\cr
<solver> = 1  =>  LS-SVM with 2D-solver\cr
<solver> = 2  =>  HINGE-SVM with 2D-solver\cr
<solver> = 3  =>  QUANTILE-SVM with 2D-solver\cr
<solver> = 4  =>  EXPECTILE-SVM with 2D-solver\cr
<solver> = 5  =>  Your SVM solver implemented in template_svm.*\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<solver>: integer between 0 and 5\cr
<NNs>:    integer between 0 and 100\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<solver> = 2\cr
<NNs>    = depends on the solver\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{T=c(<threads>,[<thread_id_offset>])}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Sets the number of threads that are going to be used. Each thread is\cr
assigned to a logical processor on the system, so that the number of\cr
allowed threads is bounded by the number of logical processors. On\cr
systems with activated hyperthreading each physical core runs one thread,\cr
if <threads> does not exceed the number of physical cores. Since hyper-\cr
threads on the same core share resources, using more threads than cores\cr
does usually not increase the performance significantly, and may even\cr
decrease it. The optional <thread_id_offset> is added before distributing\cr
the threads to the cores. This makes it possible to avoid that two or more\cr
independent processes use the same physical cores.\cr
Example: To run 2 processes with 3 threads each on a 6-core system call\cr
the first process with -T 3 0 and the second one with -T 3 3 .\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
<threads> =  0   =>   4 threads are used (all physical cores run one thread)\cr
<threads> = -1   =>   3 threads are used (all but one of the physical cores\cr
run one thread)\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<threads>:          integer between -1 and 4\cr
<thread_id_offset>: integer between  0 and 4\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<threads>          = 0\cr
<thread_id_offset> = 0\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{w=c(<neg_weight>,<pos_weight>)}\cr
\item \code{w=c(<min_weight>,<max_weight>,<size>,[<geometric>,<swap>])}\cr
\item \code{w=c(<weight_list>,[<swap>])}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Sets values for the weights, solvers should be trained with. For solvers\cr
that do not have weights this option is ignored.\cr
The first variants sets a pair of values.\cr
The second variant computes a sequence of weights of length <size>.\cr
The third variant takes the list of weights.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
size> = 1      =>  <weight1> is the negative weight and <weight2> is the\cr
positive weight.\cr
<size> > 1     =>  <size> many pairs are computed, where the positive\cr
weights are between <min_weight> and <max_weight> and\cr
the negative weights are 1 - pos_weight.\cr
<geometric>        Flag indicating whether the intermediate positive\cr
weights are geometrically or arithmetically distributed.\cr
<swap>             Flag indicating whether the role of the positive and\cr
negative weights are interchanged.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<... weight ...>:  float > 0.0 and < 1.0\cr
<size>:      integer > 0\cr
<geometric>: bool\cr
<swap>:      bool\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<weight1>   = 1.0\cr
<weight2>   = 1.0\cr
<size>      = 1\cr
<geometric> = 0\cr
<swap>      = 0\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
\item \code{W=<type>}\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Selects the working set selection method.\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Meaning of specific values:\cr
<type> = 0  =>  take the entire data set\cr
<type> = 1  =>  multiclass 'all versus all'\cr
<type> = 2  =>  multiclass 'one versus all'\cr
<type> = 3  =>  bootstrap with <number> resamples of size <size>\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Allowed values:\cr
<type>: integer between 0 and 3\cr
\ifelse{latex}{\out{\medskip}}{\cr}
Default values:\cr
<type>    = 0\cr
\ifelse{latex}{\out{\medskip}}{\cr}
\ifelse{latex}{\out{\medskip}}{\cr}
}
}

\seealso{
\link{command-args}, \code{\link{svm}}, \code{\link{init.liquidSVM}}, \code{\link{selectSVMs}}, \code{\link{predict.liquidSVM}}, \code{\link{test.liquidSVM}} and \code{\link{clean.liquidSVM}}
}
