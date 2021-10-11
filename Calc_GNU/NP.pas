unit NP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, Menus, XpMan, XPEdit,
  XPButton, ToolEdit, LbSpeedButton, ShellApi;

  const
   AlignCenter = Wm_User + 1024;

 type
   TMainFrm = class(TForm)
    CalcEditorClone: TEdit;
    CalcEditor: TXPEdit;
    MainMenu: TMainMenu;
    HelpItem: TMenuItem;
    SysInfoItem: TMenuItem;
    sp1: TMenuItem;
    SendItem: TMenuItem;
    Mail1Item: TMenuItem;
    Mail2Item: TMenuItem;
    HomePageItem: TMenuItem;
    sp2: TMenuItem;
    GNUItem: TMenuItem;
    sp3: TMenuItem;
    SourseCodeItem: TMenuItem;
    AboutItem: TMenuItem;
    FileItem: TMenuItem;
    ExitItem: TMenuItem;
    btnMC: TLbSpeedButton;
    btnMR: TLbSpeedButton;
    btnMS: TLbSpeedButton;
    btnMPlus: TLbSpeedButton;
    btnBack: TLbSpeedButton;
    btnCE: TLbSpeedButton;
    btnClear: TLbSpeedButton;
    btn7: TLbSpeedButton;
    btn8: TLbSpeedButton;
    btn9: TLbSpeedButton;
    btnDiv: TLbSpeedButton;
    btnSQRT: TLbSpeedButton;
    btn4: TLbSpeedButton;
    btn5: TLbSpeedButton;
    btn6: TLbSpeedButton;
    btnMul: TLbSpeedButton;
    btn1X: TLbSpeedButton;
    btn1: TLbSpeedButton;
    btn2: TLbSpeedButton;
    btn3: TLbSpeedButton;
    btnMinus: TLbSpeedButton;
    btn0: TLbSpeedButton;
    btnSign: TLbSpeedButton;
    btnComma: TLbSpeedButton;
    btnPlus: TLbSpeedButton;
    btnEqu: TLbSpeedButton;
    StaticText: TStaticText;
    procedure btnClearClick(Sender: TObject);
    procedure btnCEClick(Sender: TObject);
    procedure btnMCClick(Sender: TObject);
    procedure btnMRClick(Sender: TObject);
    procedure btnMSClick(Sender: TObject);
    procedure btnMPlusClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btnSignClick(Sender: TObject);
    procedure btnCommaClick(Sender: TObject);
    procedure btnPlusClick(Sender: TObject);
    procedure btnMinusClick(Sender: TObject);
    procedure btnMulClick(Sender: TObject);
    procedure btnDivClick(Sender: TObject);
    procedure btnSQRTClick(Sender: TObject);
    procedure btn1XClick(Sender: TObject);
    procedure btnEquClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure AboutItemClick(Sender: TObject);
    procedure ExitItemClick(Sender: TObject);
    procedure Mail1ItemClick(Sender: TObject);
    procedure Mail2ItemClick(Sender: TObject);
    procedure HomePageItemClick(Sender: TObject);
    procedure GNUItemClick(Sender: TObject);
    procedure SourseCodeItemClick(Sender: TObject);
    procedure SysInfoItemClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);

  private

  public

    len   : integer;

    Clear : Boolean;

    func  : (fNone, fPlus, fMinus, fMul, fDiv, fSQRT, f1X, fPercent, fSign);

    bbn   : (bStop, bGo);

    memory : real;

    First  : real;

    procedure CalcLastOperation;

    procedure DigitPressed(digit: Char);

    procedure UpdateIndicator;

    procedure ChangeMessageBoxPosition(var Msg: TMessage);
    message AlignCenter;

  end;

var
  MainFrm: TMainFrm;
  msgCaption: PChar;

implementation

uses AP;

{$R *.dfm}

procedure TMainFrm.CalcLastOperation;
var
Value, Result: Real;
begin
if bbn <> bStop then
begin
Value := strtofloat(CalcEditor.Text);
case func of
fPlus  : result := first + strtofloat(CalcEditor.Text);
fMinus : result := first - strtofloat(CalcEditor.Text);
fMul   : result := first * strtofloat(CalcEditor.Text);
fDiv   : begin
if strtofloat(CalcEditor.Text)<>0 then
result := first / strtofloat(CalcEditor.Text) else
PostMessage(Handle, WM_USER + 1024, 0, 0);
Application.MessageBox(
'Деление на нуль невозможно.',
'Калькулятор GNU',
mb_IconError + mb_OK);
end; else
Result := VAlue;
end;
First := Result;
CalcEditor.Text := floattostr(result);
Clear := true;
bbn   := bStop;
end;
end;

procedure TMainFrm.DigitPressed(digit: Char);
begin
if Clear then
begin
len   := 15;
Clear := false;
CalcEditor.Text := digit;
end else
CalcEditor.Text := CalcEditor.Text + digit;
bbn:= bGo;
end;

procedure TMainFrm.UpdateIndicator;
begin
if memory <> 0 then
statictext.Caption := 'M'
else
statictext.Caption := '';
end;

procedure TMainFrm.btnClearClick(Sender: TObject);
begin
CalcEditorClone.text:='0';
CalcEditor.Text := '0';
func   := fNone;
first  := 0;
len    := 15;
Clear  := True;
MEMORY:=0;
STATICTEXT.CAPTION:='';
CalcEditorClone.text:=FLOATTOSTR(MEMORY);
end;

procedure TMainFrm.btnCEClick(Sender: TObject);
begin
CalcEditor.Text := '0';
len := 15;
end;

procedure TMainFrm.btnMCClick(Sender: TObject);
begin
clear := true;
memory := 0;
CalcEditorClone.text:=FLOATTOSTR(MEMORY);
UpdateIndicator;
end;

procedure TMainFrm.btnMRClick(Sender: TObject);
begin
clear := true;
CalcEditor.Text := floattostr(memory); bbn:= bGo;
end;

procedure TMainFrm.btnMSClick(Sender: TObject);
begin
clear := true;
memory := strtofloat(CalcEditor.Text);
CalcEditorClone.text:=FLOATTOSTR(MEMORY);
UpdateIndicator;
end;

procedure TMainFrm.btnMPlusClick(Sender: TObject);
begin
clear  := true;
memory := memory + strtofloat(CalcEditor.Text);
CalcEditorClone.text:=FLOATTOSTR(MEMORY);
UpdateIndicator;
end;

procedure TMainFrm.btnBackClick(Sender: TObject);
var
Text: string;
begin
Text := CalcEditor.Text;
if text <> '0' then
text := copy(text, 1, length(text)-1);
if text = '' then
begin
text := '0';
Clear := True;
end;
if text = '-' then
text := '0';
CalcEditor.Text := text;
end;

procedure TMainFrm.btn7Click(Sender: TObject);
begin
DigitPressed(TSpeedButton(Sender).Caption[1]);
end;

procedure TMainFrm.btnSignClick(Sender: TObject);
var
Text: String;
begin
Text := CalcEditor.Text;
if Text[1] <> '-' then
begin
if Text<>'0' then
begin
len := 16;
Text := '-'+Text;
end;
end else
begin
len := 15;
Delete(Text,1,1);
end;
CalcEditor.Text := Text;
end;

procedure TMainFrm.btnCommaClick(Sender: TObject);
begin
if Clear then
begin
len := 15;
clear := false;
CalcEditor.Text := '0';
end;
strtoint(CalcEditor.Text);
CalcEditor.Text := CalcEditor.Text+',';
clear := false;
bbn:= bGo;
end;

procedure TMainFrm.btnPlusClick(Sender: TObject);
begin
if bbn = bStop then
func := fPlus;
CalcLastOperation;
func := fPlus;
end;

procedure TMainFrm.btnMinusClick(Sender: TObject);
begin
if bbn = bStop then
func := fMinus;
CalcLastOperation;
func := fMinus;
end;

procedure TMainFrm.btnMulClick(Sender: TObject);
begin
if bbn = bStop then
func := fMul;
CalcLastOperation;
func := fMul;
end;

procedure TMainFrm.btnDivClick(Sender: TObject);
begin
if bbn = bStop then
func := fDiv;
CalcLastOperation;
func := fDiv;
end;

procedure TMainFrm.btnSQRTClick(Sender: TObject);
begin
CalcEditor.Text := floattostr(sqrt(strtofloat(CalcEditor.Text)));
clear := true;
end;

procedure TMainFrm.btn1XClick(Sender: TObject);
begin
CalcEditor.Text := floattostr(1 / strtofloat(CalcEditor.Text));
end;

procedure TMainFrm.btnEquClick(Sender: TObject);
begin
if bbn <> bStop then
begin
CalcLastOperation;
Clear := true;
func  := fNone;
end;
end;

procedure TMainFrm.FormCreate(Sender: TObject);
begin
ModifyMenu(MainMenu.Handle, 1, mf_ByPosition or mf_Popup or mf_Help,
HelpItem.Handle, PChar(HelpItem.Caption));
len   := 15;
btnClear.Click;
end;

procedure TMainFrm.FormKeyPress(Sender: TObject; var Key: Char);
begin
case UpCase(Key) of
'0'..'9': DigitPressed(Key);
'+' : btnPlus.Click;
'-' : btnMinus.Click;
'*' : btnDiv.Click;
'/' : btnMul.Click;
'.' : btnComma.Click;
'=' : btnEqu.Click;
'C' : btnCE.Click;
end;
end;

procedure TMainFrm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
case Key of
VK_RETURN :  btnEqu.Click;
VK_BACK   :  btnBack.Click;
VK_ESCAPE :  btnClear.Click;
end;
end;

procedure TMainFrm.AboutItemClick(Sender: TObject);
begin
AboutFrm.Position := poMainFormCenter;
AboutFrm.ShowModal;
end;

procedure TMainFrm.ExitItemClick(Sender: TObject);
begin
Close;
end;

procedure TMainFrm.Mail1ItemClick(Sender: TObject);
begin
ShellExecute(Handle,'open',
'mailto:GoodWinNix@mail.ru?Subject=Notepad SE Project'+
'',
'','',SW_SHOW);
end;

procedure TMainFrm.Mail2ItemClick(Sender: TObject);
begin
ShellExecute(Handle,'open',
'mailto:viacoding@mail.ru?Subject=Notepad SE Project'+
'',
'','',SW_SHOW);
end;

procedure TMainFrm.HomePageItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'http://www.viacoding.mylivepage.ru/', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.GNUItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'http://www.gnu.org/philosophy/', nil, nil, Sw_ShowNormal);
end;

procedure TMainFrm.SourseCodeItemClick(Sender: TObject);
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if Application.MessageBox(
'Copyright @2009 Домани Олег (aka ?КТО_Я?)' + #13 +
'======================================' + #13 + #13 + '' +
'Если Вы хотите получить исходный код проекта (архив ' + #13
+ 'с компонентами по желанию пользователя), а также'
+ #13 + 'все последующие новые версии программы, то' + #13 +
'отправьте электронное письмо автору.' + #13 +
'' +  #13 + '======================================' +  #13 +
'' +  #13 +
'Отправить письмо сейчас?',
'Калькулятор GNU',
mb_IconAsterisk + mb_YesNo) = idYes then
begin
ShellExecute(Handle, 'open',
'mailto:GoodWinNix@mail.ru?Subject=Calc GNU Project' +
'&Body=Hello, please send me the source code program. Thanks!',
'', '', SW_SHOW);
end;
end;

procedure TMainFrm.SysInfoItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'Help.chm', nil, nil, Sw_ShowNormal);
end;

procedure TMainFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;

procedure TMainFrm.ChangeMessageBoxPosition(var Msg: TMessage);
var
MbHwnd: longword;
MbRect: TRect;
x, y, w, h: integer;
begin
MbHwnd := FindWindow(MAKEINTRESOURCE(WC_DIALOG), msgCaption);
if (MbHwnd <> 0) then
begin
GetWindowRect(MBHWnd, MBRect);
with MbRect do
begin
w := Right - Left;
h := Bottom - Top;
end;
x := MainFrm.Left + ((MainFrm.Width - w) div 2);
if x < 0 then
x := 0
else if x + w > Screen.Width then x := Screen.Width - w;
y := MainFrm.Top + ((MainFrm.Height - h) div 2);
if y < 0 then y := 0
else if y + h > Screen.Height then y := Screen.Height - h;
SetWindowPos(MBHWnd, 0, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;
end;

procedure TMainFrm.FormDestroy(Sender: TObject);
begin
MainFrm.OnActivate := nil;
CalcEditorClone.Free;
CalcEditor.Free;
StaticText.Free;
MainMenu.Free;
btnMinus.Free;
btnMPlus.Free;
btnClear.Free;
btnComma.Free;
btnBack.Free;
btnPlus.Free;
btnSign.Free;
btnSQRT.Free;
btnMul.Free;
btnDiv.Free;
btnEqu.Free;
btnMC.Free;
btnMR.Free;
btnMS.Free;
btnCE.Free;
btn1X.Free;
btn0.Free;
btn1.Free;
btn2.Free;
btn3.Free;
btn4.Free;
btn5.Free;
btn6.Free;
btn7.Free;
btn8.Free;
btn9.Free;
end;

end.
