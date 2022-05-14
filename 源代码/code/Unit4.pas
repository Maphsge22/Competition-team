unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, Mask;

type
  TMainForm2 = class(TForm)
    DBGrid1: TDBGrid;        {�������ݿ���ʾ}
    ADODataSetjs: TADODataSet;
    DataSourcejs: TDataSource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Editjsmc: TEdit;
    Editzbdw: TEdit;
    Editrule: TEdit;
    MaskEditb: TMaskEdit;
    MaskEdite: TMaskEdit;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    ComboBox1: TComboBox;
    Button2: TButton;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DBGrid3: TDBGrid;
    ADODataSetdw: TADODataSet;
    DataSourcedw: TDataSource;
    StaticText1: TStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm2: TMainForm2;

implementation

{$R *.dfm}

procedure TMainForm2.FormClose(Sender: TObject; var Action: TCloseAction);   {�رմ���ʱ}
begin
  Application.Terminate; {�����˳�}
end;

procedure TMainForm2.FormCreate(Sender: TObject);    {���ڴ���ʱ}
begin
  with ADOConnection1 do      {�������ݿ�}
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
    SQL.Add('select ��������,������� from ���� where ����״̬=:ddsh');   {��˶���������򣬳�ʼ��}
    Parameters.ParamByName('ddsh').Value:='�ȴ����';
    open;
    while not eof do
    begin
      ComboBox1.Items.Add(Fieldbyname('��������').AsString+'('+Fieldbyname('�������').AsString+')'); {����������}
      next;
    end;
  end;
  {����Ŀ���ʾ���о���}
  ADODataSetjs.CommandText:='select ��������,��������,���쵥λ,��ʼʱ��,����ʱ��,��ӹ��� from ����';
  ADODataSetjs.Open;
  {����Ŀ���ʾ���ж���}
  ADODataSetdw.CommandText:='select �������,��������,ѧ��.����,����.��������,ָ����ʦ.����,����״̬ from ����,ѧ��,����,ָ����ʦ where ѧ��.ѧ��=����.�ӳ�ѧ�� and ����.��������=����.�������� and ָ����ʦ.����=����.ָ����ʦ����';
  ADODataSetdw.Open;
end;

procedure TMainForm2.Button1Click(Sender: TObject);  {��������}
var
  num:integer;
  jsdh:string;
  jsmc:string;
  zbdw:string;
  begindate:string;
  enddate:string;
  rule:string;
begin
  jsmc:=trim(Editjsmc.Text);
  zbdw:=trim(Editzbdw.Text);
  begindate:=trim(MaskEditb.Text);
  enddate:=trim(MaskEdite.Text);
  rule:=trim(Editrule.Text);

  if (jsmc='') or (zbdw='') or (begindate='') or (enddate='') or (rule='') then
  begin
    ShowMessage('��Ϣû����д��ȫ');      {��ϢҪ������}
    exit;
  end;


  with ADOQuery1 do
  begin
    SQL.Clear;
    SQL.Add('select count(*) c from ����');
    open;
    num:=Fieldbyname('c').AsInteger+1;     {������������1}
    jsdh:=inttostr(num);

    SQL.Clear;               {������ľ�����Ϣ�������ݿ�}
    SQL.Add('insert into ���� values (:jsdh,:jsmc,:zbdw,:begindate,:enddate,:rule)');
    Parameters.ParamByName('jsdh').Value:=jsdh;
    Parameters.ParamByName('jsmc').Value:=jsmc;
    Parameters.ParamByName('zbdw').Value:=zbdw;
    Parameters.ParamByName('begindate').Value:=begindate;
    Parameters.ParamByName('enddate').Value:=enddate;
    Parameters.ParamByName('rule').Value:=rule;
    ExecSQL;

    ShowMessage('�������');
  end;
  ADODataSetjs.Close;        {��ʾ���º�ľ����б�}
  ADODataSetjs.CommandText:='select ��������,��������,���쵥λ,��ʼʱ��,����ʱ��,��ӹ��� from ����';
  ADODataSetjs.Open;
  
end;

procedure TMainForm2.Button2Click(Sender: TObject);  {��˶���}
var
  strs:TStrings;
  dwdh:string;
  dwxx:string;
begin
  dwxx:=trim(ComboBox1.Text);
  strs:=TStringList.Create;
  strs.Delimiter:='(';
  strs.DelimitedText:=dwxx;
  dwdh:=strs[1];
  dwdh:=copy(dwdh,1,1);  {��������ѡ��Ķ��飬�����Ķ��������ȡ����}

  with ADOQuery1 do      {�����ɺ󣬸������ݿ��е����ݣ�������ʾ�µ�}
  begin
    SQL.Clear;
    SQL.Add('update ���� set ����״̬=:zt where �������=:dwdh');
    Parameters.ParamByName('dwdh').Value:=dwdh;
    Parameters.ParamByName('zt').Value:='���ͨ��';
    ExecSQL;


    ShowMessage('���ͨ��');

    ADODataSetdw.Close;
    ADODataSetdw.CommandText:='select �������,��������,ѧ��.����,����.��������,ָ����ʦ.����,����״̬ from ����,ѧ��,����,ָ����ʦ where ѧ��.ѧ��=����.�ӳ�ѧ�� and ����.��������=����.�������� and ָ����ʦ.����=����.ָ����ʦ����';
    ADODataSetdw.Open;

    ComboBox1.Clear;
    SQL.Clear;
    SQL.Add('select ��������,������� from ���� where ����״̬=:ddsh');   {��˶���������򣬳�ʼ��}
    Parameters.ParamByName('ddsh').Value:='�ȴ����';
    open;
    while not eof do
    begin
      ComboBox1.Items.Add(Fieldbyname('��������').AsString+'('+Fieldbyname('�������').AsString+')'); {����������}
      next;
    end;
  end;
end;

end.
