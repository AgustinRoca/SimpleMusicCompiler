#include "musicCompilerUtils.h"

#define INTMAXFLAG 300
#define SIZETFLAG 400
#define PTRDIFFFLAG 500
#define LONGDOUBLEFLAG 600
#define ENDBECAUSE0 -100

char * smallocf(const char * fmt, ...){
    //create varArg lists
    va_list listS,listV;
    //initiate one
    va_start(listS,fmt);
    
    //copy to the otherones
    va_copy(listV,listS);
    
    //get length of final string and close varArg list
    int len = vsnprintf(NULL,0,fmt,listV);
    va_end(listV);

    //create the new string
    char *res = malloc(len + 1);
    if(res != NULL){
        vsnprintf(res,len + 1,fmt,listS);
    }
    va_end(listS);

    // return new string
    return res;
}

char * smallocfwd(const char * fmt, ...){
    //create varArg lists
    va_list listS,listV,list;
    //initiate one
    va_start(list,fmt);
    //copy to the otherones
    va_copy(listS,list);
    va_copy(listV,listS);
    
    //get length of final string and close varArg list
    int len = vsnprintf(NULL,0,fmt,listV);
    va_end(listV);

    //create the new string
    char *res = malloc(len + 1);
    if(res != NULL){
        vsnprintf(res,len + 1,fmt,listS);
    }
    va_end(listS);

    //free all strings
    for (int i = 0; fmt[i]!= 0; i++)
    {
        if(fmt[i]== '%'){
            int j,end,flag;
            for (j = i,end=0,flag = 0; !end ; j++)
            {
                switch (fmt[j])
                {
                case 's':
                    free(va_arg(list,char *));
                    end = 1;
                    break;
                case 'd':
                case 'i':
                case 'o':
                case 'u':
                case 'x':
                case 'X':
                case 'c':
                    if (flag == 1)
                    {
                        va_arg(list,long int);
                    }else if(flag == 2){
                        va_arg(list,long long int);
                    }else{
                        va_arg(list,int);
                    }
                    end = 1;
                    break;
                case 'P':
                case 'n':
                    va_arg(list,void *);
                    end = 1;
                    break;
                case 'e':
                case 'E':
                case 'f':
                case 'F':
                case 'g':
                case 'G':
                case 'a':
                case 'A':
                    if (flag == LONGDOUBLEFLAG)
                    {
                        va_arg(list,long double);
                    }else
                    {
                        va_arg(list,double);
                    }
                    end = 1;
                    break;
                case 'm':
                    end = 1;
                    break;
                case 'l':
                    flag++;
                    break;
                case 'h':
                    flag--;
                    break;
                case 'L':
                    flag = LONGDOUBLEFLAG;
                    break;
                case 0:
                    end = ENDBECAUSE0;
                default:
                    break;
                }
                if(end == ENDBECAUSE0){
                    i = j-1;
                }else{
                    i = j;
                }
            }
        }
    }
    
    va_end(list);


    // return new string
    return res;
}