import numpy as np

## This is a class to process data

class Read_Data:
    def __init__(self):
        self.dir_name=''
        self.data_type='dat'
        self.size_sufx='size'
        self.index=0
        self.name=''
        print 'An read data class is constructed.\n'

    def set_data_info(self,dir_name,index=0,data_type='dat',size_sufx='size'):
        self.dir_name=dir_name
        self.index=index
        self.data_type=data_type
        self.size_sufx=size_sufx

    def set_data_name(self,name):
        self.name=name


    def load_bin_cetr(self):
        s=self.name[0:2]
        if s[0]=='R':
            ind_cpx=0
        else:
            ind_cpx=1
        if s[1]=='1':
            dim='1d'
        elif s[1]=='2':
            dim='2d'
        else:
            dim='3d'
        dir_name=self.dir_name
        if self.index!=-1:
            dir_name=self.dir_name+'_'+str(self.index)
        return self.load_bin(dir_name,self.name,self.data_type,self.size_sufx,dim,ind_cpx)


    def load_bin(self,dir_name,name,data_type,size_sufx,dim,ind_cpx):
        name_size=self.mody_size_pre_fx(name)+'_'+str(size_sufx)
        name_data=self.add_dir_name(dir_name,name)
        name_size=self.add_dir_name(dir_name,name_size)

        name_data=self.add_type(name_data,data_type)
        name_size=self.add_type(name_size,data_type)

        size=np.fromfile(name_size, dtype=float)

        if dim=='1d':
            n=size[0]
            if ind_cpx==0:
                fx=np.fromfile(name_data, dtype=float)
            else:
                f=np.fromfile(name_data, dtype=float)
                real = f[0:2 * n:2]
                img = f[1:2 * n + 1:2]
                fx = real + 1j * img
        elif dim=='2d':
            m=size[0]
            n=size[1]
            N=m*n
            if ind_cpx==0:
                f = np.fromfile(name_data, dtype=float)
                fx = np.reshape(f, (m, n), order="F")
            else:
                f = np.fromfile(name_data, dtype=float)
                real = f[0:2 * N:2]
                img = f[1:2 * N + 1:2]
                real=np.reshape(real, (m, n), order="F")
                img = np.reshape(img, (m, n), order="F")
                fx = real + 1j * img
        else:
            m=size[0]
            n=size[1]
            l=size[2]
            N=m*n*l
            if ind_cpx==0:
                f = np.fromfile(name_data, dtype=float)
                fx = np.reshape(f, (m, n,l), order="F")
            else:
                f = np.fromfile(name_data, dtype=float)
                real = f[0:2 * N:2]
                img = f[1:2 * N + 1:2]
                real=np.reshape(real, (m, n,l), order="F")
                img = np.reshape(img, (m, n,l), order="F")
                fx = real + 1j * img
        return fx


    def add_dir_name(self,dir_name,name):
        return dir_name+'/'+name

    def mody_size_pre_fx(self,string):
        string=list(string)
        string[0:2]='R1'
        return ''.join(string)

    def add_type(self,name,type):
        return name+'.'+type








