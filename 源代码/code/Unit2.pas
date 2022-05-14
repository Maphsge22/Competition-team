unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DB, ADODB;


type
  TRegisterForm = class(TForm)
    {����������ǩ}
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;

    ButtonRegister: TButton;

    EditName: TEdit;
    EditPassword: TEdit;
    MaskEditXh: TMaskEdit;      {�����û�ֻ�ܰ��ռȶ��������ʽ����}
    MaskEditSjh: TMaskEdit;
    EditRName: TEdit;
    ComboBox1: TComboBox;       {����ȡֵ��}

    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    StaticText1: TStaticText;

    procedure ButtonRegisterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegisterForm: TRegisterForm;

implementation

{$R *.dfm}


procedure TRegisterForm.ButtonRegisterClick(Sender: TObject);
var
  username:string;
  password:string;
  realname:string;
  xh:string;
  xydh:string;
  sjh:string;
begin
  username:=trim(EditName.Text);
  password:=trim(EditPassword.Text);
  realname:=trim(EditRName.Text);
  xh:=trim(MaskEditXh.Text);
  sjh:=trim(MaskEditSjh.Text);
  if (username='') or (password='') then     {�û����������벻����Ϊ��}
  begin                                  {������ϢҲ����Ϊ�գ�����ADOQuery1��ʵ��}
    ShowMessage('�û���������Ϊ��');
    exit;
  end;

  with ADOQuery1 do
     begin
     SQL.Clear;
     SQL.Add('select * from �û� where �û���=:username');
     Parameters.ParamByName('username').Value:=username;
     open;
     if not(ADOQuery1.IsEmpty) then
     begin
       ShowMessage('�û��Ѵ���');      {���ܴ�������û���}
       exit;
     end;

     SQL.Clear;
     SQL.Add('select ѧԺ���� from ѧԺ where ѧԺ����=:xymc');
     Parameters.ParamByName('xymc').Value:= ComboBox1.Text;
     open;
     xydh:=Fieldbyname('ѧԺ����').AsString;
          
     if (xydh='') or (realname='') or (xh='') or (sjh='') then
     begin
       ShowMessage('��Ϣδ��д��ȫ');      {������ϢҲ����Ϊ��}
       exit;
     end;

     SQL.Clear;        {�����ݿ��в�����ע�������û���Ϣ}
     SQL.Add('insert into �û� values(:username,:password,:xh,:therole)');
     Parameters.ParamByName('username').Value:=username;
     Parameters.ParamByName('password').Value:=password;
     Parameters.ParamByName('xh').Value:=xh;
     Parameters.ParamByName('therole').Value:='0';
     ExecSQL;

     SQL.Clear;
     SQL.Add('insert into ѧ�� values(:xm,:xh,:xydh,:sjh)');
     Parameters.ParamByName('xm').Value:=realname;
     Parameters.ParamByName('xh').Value:=xh;
     Parameters.ParamByName('xydh').Value:=xydh;
     Parameters.ParamByName('sjh').Value:=sjh;
     ExecSQL;
     ShowMessage('ע��ɹ�');
     RegisterForm.Hide;
  end;
end;


procedure TRegisterForm.FormCreate(Sender: TObject);   {ҳ���ʼ��ʱ�Ĳ���}
var xymc:string;
begin
  with ADOConnection1 do            {1. �������ݿ�}
    begin
      Connected := False;
      ConnectionString  := 'Provider=MSDASQL.1;Persist Security Info=False;User ID=root;Data Source=dataMysql;Initial Catalog=jsfbjzd';
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
     SQL.Add('select ѧԺ���� from ѧԺ');      {2. ������������Ҫչʾʲô��Ϣ}
     open;
     while not eof do
     begin
        xymc:=Fieldbyname('ѧԺ����').AsString;
        next;
        ComboBox1.Items.Add(xymc);
     end;
   end;
end;

end.
