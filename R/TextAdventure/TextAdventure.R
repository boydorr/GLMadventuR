setting_up_the_problem <- "Welcome to the Viking village of Berk, located on a remote island, is attacked
frequently by dragons, which take livestock and damage property. You are Hiccup, the awkward
fifteen-year-old son of the village chieftain, Stoick the Vast, and are considered too scrawny and
weak to hunt the dragons. Instead you resolve to study them and the effect that your village's
hunting and livestock management has on dragon numbers."

experimental_design <- "The island Berk is built on can be divided into approximately 10 even sized
regions. You will set up a sampling station in each of these regions to monitor dragon population size
as well as some environmental covariates. You have been told that the main covariates that are likely
to affect dragon population size are sheep number (count), vegetation height (numeric), hunting
intensity (low, medium, high), the presence of a unicorn colony (1 or 0). Thanks to your status as
the firstborn of the village chieftain you have a lot of helpers, this means you will have records
collected from all your sites simultaneously over the course of a month."

weight_vs_count <- "During your apprenticeship with Gobber, the village blacksmith, you have built
an assortment of mechanical devices. You think two of these might allow you to get a handle on the
population size of the dragons around Berk. The first is a large weighing scale stationed
next to a dragon feeder (used to monitor dragon health in Gobber's training ring). The second is
an automatedcounter which can be set up to count the number of dragons that fly within its sights. You only have
the materials to run one of these techniques at each of your sites so you need to choose between counting
and weighing dragons. Which will it be? Think about the ecological and modelling consequences for
your choice."

visualise_your_data <- "Now that you have collected your data (see the object 'dragons') it might be a good idea to explore it.
We recommend you visualise the collected data and look at a range of summary statistics."

model_family_selection <- "Choosing which probability distribution (or family) your data come from is
often challenging. While students are often tempted to plot a histogram of their data to determine
this, these visualisations can often be misleading. Instead, try to think of the characteristics
of the population you are collecting from. Are your data numbers or categories? In the case of a
population size they are likely to be numbers. If so, are they whole numbers (discrete) or can they
be decimals (continuous)? Can the numbers go below zero?

Here are four distributions and their qualities, which do you think will be the best fit for your
data?
"

poisson_for_mass <- "You have selected the Poisson distribution. The Poisson is a positive, discrete
distribution and thus is best for modelling integer values. Your masses can be both whole and decimal
numbers, therefore the Poisson may not be the optimum distribution for the data you collected. Would you
like to choose a different distribution?"

normal_for_count <- "You have selected the Normal distribution. The Normal is a continuous
distribution and thus might not be the best distribution for discete data (like your counts). Would you
like to choose a different distribution?"


