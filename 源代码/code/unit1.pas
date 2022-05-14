unit unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  Unit2, Unit3, Unit4, Unit5, DB, ADODB, ExtCtrls;

type
  TLoginForm = class(TForm)
    ButtonLogin: TButton;       {��¼��ť}
    ButtonRegister: TButton;    {ע�ᰴť}
    Label1: TLabel;             {���û�����}
    Label2: TLabel;             {�����롱}
    EditName: TEdit;            {���û���}
    EditPassword: TEdit;        {������}
    ADOConnection1: TADOConnection;    {�������ݿ�}
    ADOQuery1: TADOQuery;       {���ݿ�����}
    RadioGroup1: TRadioGroup;
    Label3: TLabel;
    StaticText1: TStaticText;    {ѡ���ɫ}
    procedure ButtonRegisterClick(Sender: TObject); {���ע��}
    procedure ButtonLoginClick(Sender: TObject); {�����¼}
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginForm: TLoginForm;


implementation

{$R *.dfm}



procedure TLoginForm.ButtonRegisterClick(Sender: TObject);  {��ʾע��ҳ��}
begin
  RegisterForm.show;     {����unit2}
end;

procedure TLoginForm.ButtonLoginClick(Sender: TObject);  {�����¼����ʾ��ҳ��}
var
  username:string;
  password:string;
  realpassword:string;
begin
  username:=trim(EditName.Text);
  password:=trim(EditPassword.Text);
  if (username='') or (password='') then     {�����û��ľ͵��˵�¼}
  begin
    ShowMessage('��Ϣδ��д��ȫ');
    exit;
  end;

  with ADOConnection1 do          {�������ݿ�}
    begin
      Connected := False;
      ConnectionString := 'Provider=MSDASQL.1;Persist Security Info=False;User ID=root;Data Source=dataMysql;Initial Catalog=jsfbjzd';
    try
      Connected:=True;
    except
      ShowMessage('not connected');
      raise;
      Exit;
    end;
  end;

  with ADOQuery1 do
  begin
    SQL.Clear;
    SQL.Add('select ѧ��,����,��ɫ from �û� where �û���=:username');
    Parameters.ParamByName('username').Value:=username;
    open;
    wdxh:=Fieldbyname('ѧ��').AsString;
    if IsEmpty then
      begin
        ShowMessage('�û�������');    {���ݿ���û������û���}
        exit;
      end
    else    {�ҵ�����û���}
      begin
        realpassword:=Fieldbyname('����').AsString;
        if realpassword<>password then       {���벻ƥ��}
          begin
            ShowMessage('�������');
            exit;
          end;

        if (RadioGroup1.Items[RadioGroup1.ItemIndex]='ѧ��') and (Fieldbyname('��ɫ').AsString='0') then
        begin
          Application.CreateForm(TMainForm1, MainForm1);   {ѧ����¼����ת��unit3}
          MainForm1.Show;
          LoginForm.Hide;
        end
        else if (RadioGroup1.Items[RadioGroup1.ItemIndex]='����Ա') and (Fieldbyname('��ɫ').AsString='1') then
        begin
          Application.CreateForm(TMainForm2, MainForm2);
          MainForm2.Show;          {����Ա��¼����ת��unit4}
          LoginForm.Hide;
        end
        else
        begin
          ShowMessage('��ɫ����');    {����ԽȨ����}
        end;

      end;
  end;

end;

end.
