unit AP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, XPLabel, ExtCtrls, XPButton, XPGroupBox, StdCtrls,
  ComCtrls, ShellApi, jpeg, Animate, GIFCtrl;

type
  TAboutFrm = class(TForm)
    tx3: TXPLabel;
    tx4: TXPLabel;
    tx5: TXPLabel;
    tx6: TXPLabel;
    tx7: TXPLabel;
    tx8: TXPLabel;
    Cancel: TXPButton;
    tx2: TXPLabel;
    spr1: TBevel;
    spr2: TBevel;
    tx9: TXPLabel;
    RxGIFAnimator: TRxGIFAnimator;
    logo: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx7MouseLeave(Sender: TObject);
    procedure tx7MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx7MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure tx7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure tx2Click(Sender: TObject);
    procedure tx2MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure tx2MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx2MouseLeave(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tx9Click(Sender: TObject);
    procedure tx9MouseLeave(Sender: TObject);
    procedure tx9MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx9MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);

  private

    procedure CMMouseLeave(var msg: TMessage);
    message CM_MOUSELEAVE;

  public

  end;

var
  AboutFrm: TAboutFrm;



implementation

{$R *.dfm}

procedure TAboutFrm.CMMouseLeave(var msg: TMessage);
begin
tx7.ForegroundColor := $00FF8000;
tx2.ForegroundColor := $00FF8000;
end;

procedure TAboutFrm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
Close;
end;

procedure TAboutFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;

procedure TAboutFrm.tx7MouseLeave(Sender: TObject);
begin
tx7.ForegroundColor := $00FF8000;
end;

procedure TAboutFrm.tx7MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx7.ForegroundColor := $00FF8000;
end;

procedure TAboutFrm.tx7MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
tx7.ForegroundColor := clRed;
end;

procedure TAboutFrm.tx7Click(Sender: TObject);
begin
ShellExecute(Handle,'open',
'mailto:GoodWinNix@mail.ru?Subject=Notepad SE Project'+
'',
'','',SW_SHOW);
end;

procedure TAboutFrm.FormShow(Sender: TObject);
begin
SetWindowLong(AboutFrm.Handle, GWL_EXSTYLE,
GetWindowLOng(AboutFrm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TAboutFrm.FormDestroy(Sender: TObject);
begin
AboutFrm.OnActivate := nil;
RxGIFAnimator.Free;
Cancel.Free;
Logo.Free;
spr1.Free;
spr2.Free;
tx2.Free;
tx3.Free;
tx4.Free;
tx5.Free;
tx6.Free;
tx7.Free;
tx8.Free;
tx9.Free;
end;

procedure TAboutFrm.LogoClick(Sender: TObject);
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
Application.MessageBox('Вы имеете право распространять и использовать Notepad SE' +
#13 + 'в любых целях при условии целостности оригинального' + #13 + 'дистрибутива.',
'Notepad SE',
mb_IconAsterisk + mb_OK);
end;

procedure TAboutFrm.tx2Click(Sender: TObject);
begin
ShellExecute(Handle, nil, 'http://www.viacoding.mylivepage.ru/', nil,nil, Sw_ShowNormal);
end;

procedure TAboutFrm.tx2MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
tx2.ForegroundColor := clRed;
end;

procedure TAboutFrm.tx2MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx2.ForegroundColor := $00FF8000;
end;

procedure TAboutFrm.tx2MouseLeave(Sender: TObject);
begin
tx2.ForegroundColor := $00FF8000;
end;

procedure TAboutFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Cancel.SetFocus;
end;

procedure TAboutFrm.tx9Click(Sender: TObject);
begin
ShellExecute(Handle,'open',
'mailto:viacoding@mail.ru?Subject=Notepad SE Project'+
'',
'','',SW_SHOW);
end;

procedure TAboutFrm.tx9MouseLeave(Sender: TObject);
begin
tx9.ForegroundColor := $00FF8000;
end;

procedure TAboutFrm.tx9MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx9.ForegroundColor := $00FF8000;
end;

procedure TAboutFrm.tx9MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
tx9.ForegroundColor := clRed;
end;

end.
