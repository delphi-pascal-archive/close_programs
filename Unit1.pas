unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    Button2: TButton;
    Button1: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Button3: TButton;
    CheckBox4: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure KillProgram(ClassName: PChar; WindowTitle: PChar);
    { Public declarations }
  end;

var
  Form1: TForm1;
  i:integer;
implementation

{$R *.DFM}


procedure TForm1.KillProgram(ClassName: PChar; WindowTitle: PChar);
const
 PROCESS_TERMINATE = $0001;
var
 ProcessHandle:THandle;
 ProcessID:Integer;
 TheWindow:HWND;
begin
 TheWindow:=FindWindow(Classname, WindowTitle);
 GetWindowThreadProcessID(TheWindow, @ProcessID);
 ProcessHandle:=OpenProcess(PROCESS_TERMINATE, FALSE, ProcessId);
 TerminateProcess(ProcessHandle,4);
end;

procedure TForm1.Button1Click(Sender: TObject);
VAR
 Wnd : hWnd;
 buff: array [0..127] of Char;
begin
 ListBox1.Clear;
 Wnd:=GetWindow(Handle, gw_HWndFirst);
 while Wnd<>0 do
  begin //Не показываем:
   if (Wnd<>Application.Handle) and //-Собственное окно
   (IsWindowVisible(Wnd)or checkbox1.checked) and //-Невидимые окна
   ((GetWindow(Wnd, gw_Owner)=0) or checkbox2.checked) and //-Дочернии окна
   (GetWindowText(Wnd, buff, sizeof(buff))<>0) //-Окна без заголовков
    then
     begin
      GetWindowText(Wnd, buff, sizeof(buff));
      ListBox1.Items.Add(StrPas(buff));
     end;
    Wnd:=GetWindow(Wnd, gw_hWndNext);
  end;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
 Killprogram(nil,pchar(ListBox1.Items.Strings[ListBox1.ItemIndex]));
 Sleep(100);
 Button1Click(Form1);
 if i=ListBox1.Items.Count
  then ListBox1.Selected[i-1]:=true
 else
  ListBox1.Selected[i]:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Button1Click(Form1);
 Application.Title:='Close Program';
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
 Button1Click(Form1);
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
 Button1Click(Form1);
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
 if Listbox1.Sorted=false then Listbox1.Sorted:=true
 else Listbox1.Sorted:=false;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
 i:=ListBox1.ItemIndex;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 WinExec(Pchar('rundll32 shell32,SHExitWindowsEx 2'),sw_Show);
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
 if Button3.Enabled=false then
  begin
   Button3.Enabled:=true;
   CheckBox4.Caption:='ON';
  end
 else
  begin
   Button3.Enabled:=false;
   CheckBox4.Caption:='OFF';
  end;
end;

end.
