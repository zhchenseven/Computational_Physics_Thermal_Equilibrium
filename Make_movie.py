import numpy as np
from READ_DATA import Read_Data
import cv2
import matplotlib.pyplot as plt
import os
from  pylab import  *
from scipy import interpolate
## This function helps read file from the dat and make movie

class Gen_movie:
    def __init__(self):
        self.M=0
        self.fd_name=''
        self.index=0
        self.x=[]
        self.x_name=''
        self.ind_track=[]
        self.ind_track_name=''
        self.itr_dif=[]
        self.itr_dif_name=''
        self.itr_track=[]
        self.fx=[]
        self.fx_name=''
        self.data_type='dat'
        self.size_sufx='size'
        self.read=Read_Data()

        self.mov_name=''
        self.fps=10
        self.fine_fac=2


    def set_basic(self,M,fd_name,data_type='dat',size_sufx='size',index=0):
        self.M=M
        self.fd_name=fd_name
        self.data_type=data_type
        self.size_sufx=size_sufx
        self.index=index

    def set_var(self,x_name,ind_track_name,itr_dif_name,fx_name):
        self.x_name=x_name
        self.ind_track_name=ind_track_name
        self.itr_dif_name=itr_dif_name
        self.fx_name=fx_name

    def ini_read(self):
        self.read.set_data_info(self.fd_name,self.index,self.data_type,self.size_sufx)

    def read_x(self):
        self.read.set_data_name(self.x_name)
        self.x=self.read.load_bin_cetr()
        self.read.set_data_name(self.fx_name)
        self.fx=self.read.load_bin_cetr()

    def read_itr_info(self):
        self.read.set_data_name(self.ind_track_name)
        self.ind_track=self.read.load_bin_cetr()

        self.read.set_data_name(self.itr_dif_name)
        self.itr_dif=self.read.load_bin_cetr()

    def set_movie_para(self,mov_name,fps,fine_fac):
        self.mov_name=mov_name
        self.fps=fps
        self.fine_fac=fine_fac

    def read_raw_data(self):
        self.ini_read()
        self.read_x()
        self.read_itr_info()

    def get_save_name(self,l):
        if l < 10:
            name0 = '000' + str(l)
        elif l < 100:
            name0 = '00' + str(l)
        elif l < 1000:
            name0 = '0' + str(l)
        else:
            name0 = str(l)
        return 'frm' + name0 + '_' + str(self.index) + '.png'

    def incl_path(self,name):
        return self.fd_name+'_'+str(self.index)+'/'+name

    def gen_movie(self):
            y_max=np.max(self.itr_dif)
            y_max*=1.05
            f_max=  1.05*self.fx.max()
            for i in range(0, self.M + 1):
                print ('generate movie finished', 100 * (i + 1) / (self.M+1), '%')
                j = i + 1
                name = self.get_save_name(j)
                name=self.incl_path(name)
                if i != self.M:
                    fig1= plt.figure()
                    plt.subplot(2, 1, 1)
                    plt.semilogy(np.arange(0,self.ind_track[i]+1), self.itr_dif[0:self.ind_track[i]+1], linewidth=1,color='r')
                    plt.xlim(0, self.ind_track[-1])
                    plt.ylim(0, 1.05 * y_max)
                    plt.xlabel('iteration')
                    plt.ylabel('inf_norm_dif')
                    plt.title('Difference Norm trace when iteraction='+str(self.ind_track[i]+1))
                    plt.grid(True)
                    # plt.legend(legd_lst, loc='best',fontsize=7)
                    plt.subplot(2,1,2)
                    x_new, y_new, Z = self.interp_2D(self.x, self.x, self.fx[:, :, i], self.fine_fac)
                    X, Y = np.meshgrid(x_new, y_new)
                    plt.pcolormesh(X, Y, Z, shading='gouraud',vmin=0,vmax=f_max)
                    # plt.plot([x[0], x[-1]], [0, 0], linewidth=1, color='magenta')
                    # plt.plot([0, 0], [x[0], x[-1]], linewidth=1, color='magenta')
                    plt.title("T ")
                    plt.xlabel('$x_1$')
                    plt.ylabel('$x_2$')
                    axis('equal')
                    plt.colorbar()
                    fig1.savefig(name)
                    plt.close()
                else:
                    fig1 = plt.figure()
                    plt.subplot(2, 1, 1)
                    plt.plot([], [])
                    plt.subplot(2, 1, 2)
                    plt.plot([], [])
                    fig1.savefig(name)
                    plt.close()

            name=self.get_save_name(1)
            name=self.incl_path(name)
            img = cv2.imread(name)
            height, width, layers = img.shape
            #fourcc = cv2.VideoWriter_fourcc(*'DIVX')
            if os.name=='nt':
                fourcc = cv2.VideoWriter_fourcc(*'DIVX')
            else:
                fourcc=cv2.cv.CV_FOURCC(*'avc1')
            #fourcc = cv2.VideoWriter_fourcc(*'avc1')
            #fourcc = cv2.VideoWriter_fourcc(*'DIVX')
            #fourcc=cv2.cv.CV_FOURCC(*'XVID')
            mov_name = self.mov_name +'_'+ str(self.index) + '.avi'
            mov_name=self.incl_path(mov_name)
            video = cv2.VideoWriter(mov_name, fourcc, self.fps, (width, height))
            for i in range(0,self.M+1):
                j=i+1
                print ('movies finished', 100 * i / self.M, '%')
                name=self.get_save_name(j)
                name=self.incl_path(name)
                img = cv2.imread(name)
                video.write(img)
                os.remove(name)
            cv2.destroyAllWindows()
            video.release()

    def interp_2D(self, x, y, Z, fine_fac):
        dx = x[1] - x[0]
        dy = y[1] - y[0]
        f = interpolate.RectBivariateSpline(y, x, Z)
        dx = dx / fine_fac
        dy = dy / fine_fac
        xnew = np.arange(x[0], x[-1] + dx, dx)
        ynew = np.arange(y[0], y[-1] + dy, dy)
        znew = f(ynew, xnew)
        return (xnew, ynew, znew)

