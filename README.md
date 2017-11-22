# Computational_Physics_Thermal_Equilibrium
Thermal equilibrium states are ubiquitous in nature. Following the classical thermal dynamics, we can describe such states using the elliptical type of Laplace equation. Due to the advent of tremendous power of computers, we can, instead of the analytical solutions of the old-school style, alternatively using numerical methods to study the thermal dynamic systems in equilibrium. Here, I present our work using the finite difference numerical schemes to iteratively evolve the solutions to an arbitrarily given precision requirement. The code provides the object-oriented codes to solve the problem, visualize the results, and make animations of the iterative processes. 

The code is for the first course project in computational fluid dynamics (MASE 5412) in Washington University in St. Louis. 

Here, we adopt the object-oriented numerical framework to simulate the physics. The .h and .cpp files that are not beginning with 'run' are files are the classes for defining the numerical procedures. Specifically, Para.cpp and Para.h defines the physical parameters for the equation, the set-up, and for the mesh. IBC.cpp and IBC.h defines the initial and boundary conditions for a specified selection. Then, Evo_dynam.cpp and Evo_dynam.h evolves the iterations that leads to the convergence of thermal equilibrium states. Finally, Data_process.cpp and Data_process.h processes and stores the data, which are further visualized, animated, and interpreted using python.

The run_*.cpp files provide main functions to invoke, embody the class and define a numerical investigations. Various .cpp files are for the case of various parameters.

Here, we employ the python files for processing data and generating animations. In doing so, READ_DATA.py and Make_movie.py define the classes. gen_movie_script.py provides the main function.

The MATLAB files also provide the funtionality for visualizing the results by plotting the 2D thermal equilibrium state. In particular, read_2D_data_1.m provides the main function for plotting while other .m files are auxiliary functions to be invoked. 


Here, we also provide the necessary information for running the code. 
For the MATLAB code, MATLAB on any platform that are after MATLAB 2014b should work.
For the python code, the project work by using the pycharm IDE with specified anaconda library. One thing that is worth noting is one may need to install the opencv3 for generating the animations. 
For the C++ code, we invoke the Armadillo library (http://arma.sourceforge.net/) that provides MATLAB-like functions for linear algebra operations. For the Windows user, one needs to install the MS Visual Studio 2015, and open the example1_win64.vcxproj for running the code. For the Mac OS or Ubuntu user, one needs to install the armadillo library at first (please refer to the readme.txt in the downloaded armadillo package), then compile and link the codes.

In the end, we attach several sub-folders to show the animations that represent the results and the error iteratively. This includes the cases of various mesh points. You are very welcome to watch and comment on the animations.
