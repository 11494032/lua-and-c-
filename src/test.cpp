#include <iostream>
using namespace std;

extern "C"  
{  
    #include "lua.h"  
    #include "lauxlib.h"  
    #include "lualib.h"  
}  
 
void test()
{
    cout<<"test"<<endl; 
	//1.创建一个state  
    lua_State *L = luaL_newstate();  
       
    //2.入栈操作  
    lua_pushstring(L, "I am so cool~");   
    lua_pushnumber(L,20);  
   
    //3.取值操作  
    if( lua_isstring(L,1)){             //判断是否可以转为string  
        cout<<lua_tostring(L,1)<<endl;  //转为string并返回  
    }  
    if( lua_isnumber(L,2)){  
        cout<<lua_tonumber(L,2)<<endl;  
    }  
   
    //4.关闭state  
    lua_close(L);  
}

/*

str = "I am so cool"  
tbl = {name = "shun", id = 20114442}  
function add(a,b)  
    return a + b  
end

*/

void test_file()
{
    //1.创建Lua状态  
    lua_State *L = luaL_newstate();  
    if (L == NULL)  
    {  
        return ;  
    }  
   
    //2.加载Lua文件  
    int bRet = luaL_loadfile(L,"hello.lua");  
    if(bRet)  
    {  
        cout<<"load file error"<<endl;  
        return ;  
    }  
   
    //3.运行Lua文件  
    bRet = lua_pcall(L,0,0,0);  
    if(bRet)  
    {  
        cout<<"pcall error"<<endl;  
        return ;  
    }  
   
    //4.读取变量  
    lua_getglobal(L,"str");  
    string str = lua_tostring(L,-1);  
    cout<<"str = "<<str.c_str()<<endl;        //str = I am so cool~  
   
    //5.读取table  
    lua_getglobal(L,"tbl");   
    lua_getfield(L,-1,"name");  
    str = lua_tostring(L,-1);  
    cout<<"tbl:name = "<<str.c_str()<<endl; //tbl:name = shun  
   
    //6.读取函数  
    lua_getglobal(L, "add");        // 获取函数，压入栈中  
    lua_pushnumber(L, 10);          // 压入第一个参数  
    lua_pushnumber(L, 20);          // 压入第二个参数  
    int iRet= lua_pcall(L, 2, 1, 0);// 调用函数，调用完成以后，会将返回值压入栈中，2表示参数个数，1表示返回结果个数。  
    if (iRet)                       // 调用出错  
    {  
        const char *pErrorMsg = lua_tostring(L, -1);  
        cout << pErrorMsg << endl;  
        lua_close(L);  
        return ;  
    }  
    if (lua_isnumber(L, -1))        //取值输出  
    {  
        double fValue = lua_tonumber(L, -1);  
        cout << "Result is " << fValue << endl;  
    }  

    //4.读取变量  
    lua_getglobal(L,"tbl");   
    lua_getfield(L,-1,"id");  
    int num = lua_tonumber(L,-1);  
    cout<<"id = "<< num <<endl;        //id = I20114442 
   
    //2.入栈操作  


    lua_pushstring(L, "I am so cool~");   
    lua_pushnumber(L,20);  
    lua_pushnumber(L,30); 
    lua_pushnumber(L,40); 

    //3.取值操作  
	if( lua_isnumber(L,-1 )){  
        cout<<"num2:"<<lua_tonumber(L,-1)<<endl;  
    }  
   if( lua_isnumber(L,-2)){  
        cout<<"num2:"<<lua_tonumber(L,-2)<<endl;  
    } 
    if( lua_isnumber(L,-3)){  
        cout<<"num1:"<<lua_tonumber(L,-3)<<endl;  
    }  
    if( lua_isstring(L,-4)){             //判断是否可以转为string  
        cout<<"string :"<<lua_tostring(L,-4)<<endl;  //转为string并返回  
    }  
  
   
  
	 

    //7.关闭state  
    lua_close(L);  
}
int main( int argc, char **argv )
{
	

  test();
  test_file();
	
   


}

