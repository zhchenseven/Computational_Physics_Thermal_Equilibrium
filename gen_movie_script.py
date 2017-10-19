from Make_movie import Gen_movie


Movie=Gen_movie()
M=50
fd_name='laplace_N_128'
index=0
data_type='dat'
size_sufx='size'

Movie.set_basic(M,fd_name,data_type,size_sufx,index)

x_name='R1_x'
ind_track_name='R1_ind_track'
itr_dif_name='R1_itr_dif'
fx_name='R3_T_track'

mov_name='demo'
fps=10
fine_fac=4
Movie.set_movie_para(mov_name,fps,fine_fac)

Movie.set_var(x_name,ind_track_name,itr_dif_name,fx_name)
Movie.read_raw_data()
Movie.gen_movie()