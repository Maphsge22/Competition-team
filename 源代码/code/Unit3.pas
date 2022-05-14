unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls,
  Unit5, DBCtrls, ExtCtrls;

type
  TMainForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    ADODataSetjs: TADODataSet;
    DBGrid1: TDBGrid;
    DataSourcejs: TDataSource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Editdwmc: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ADOQuery1: TADOQuery;
    Button1: TButton;
    ADODataSetzdls: TADODataSet;
    DataSourcezdls: TDataSource;
    DBGrid2: TDBGrid;
    ADODataSetdw: TADODataSet;
    DataSourcedw: TDataSource;
    DBGrid3: TDBGrid;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    ComboBox3: TComboBox;
    Button2: TButton;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    ComboBox4: TComboBox;
    Button3: TButton;
    Button4: TButton;
    RadioGroup1: TRadioGroup;
    GroupBox4: TGroupBox;
    ComboBox5: TComboBox;
    DBGrid4: TDBGrid;
    Button5: TButton;
    DataSourcedwgc: TDataSource;
    ADODataSetdwgc: TADODataSet;
    Button6: TButton;
    StaticText1: TStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm1: TMainForm1;

implementation

{$R *.dfm}

procedure TMainForm1.FormClose(Sender: TObject; var Action: TCloseAction);  {�رմ���ʱ}
begin
  Application.Terminate; {�����˳�}
end;

procedure TMainForm1.FormCreate(Sender: TObject);   {���ڳ�ʼ��ʱ}
begin
  with ADOConnection1 do       {�������ݿ�}
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
    
  MainForm1.Caption:='�������������ϵͳ--��ǰ�û�:'+wdxh;    {���ڵı��⣬��ʾ�û�ѧ��}

  with ADOQuery1 do
  begin
    SQL.Clear;
    SQL.Add('select �������� from ����');
    open;
    while not eof do
    begin
      ComboBox1.Items.Add(Fieldbyname('��������').AsString);  {���μӾ�����������}
      next;
    end;
    
    SQL.Clear;
    SQL.Add('select ����,���� from ָ����ʦ');
    open;
    while not eof do   {��ָ����ʦ��������}
    begin
      ComboBox2.Items.Add(Fieldbyname('����').AsString+'('+Fieldbyname('����').AsString+')');
      next;
    end;

    SQL.Clear;
    SQL.Add('select ��������,������� from ����');
    open;

    while not eof do
    begin
      {�����������顱������}
      ComboBox3.Items.Add(Fieldbyname('��������').AsString+'('+Fieldbyname('�������').AsString+')');
      {���鿴������ɡ�������}
      ComboBox5.Items.Add(Fieldbyname('��������').AsString+'('+Fieldbyname('�������').AsString+')');
      next;
    end;

    SQL.Clear;
    SQL.Add('select ����,ѧ��.ѧ�� as ѧ��ѧ��,����.������� from ��������,ѧ��,���� where ѧ��.ѧ��=��������.��Աѧ�� and ��������.�������=����.������� and ����.�ӳ�ѧ��=:wdxh');
    Parameters.ParamByName('wdxh').Value:=wdxh;
    open;
    wddwdh:=Fieldbyname('�������').AsString;
    while not eof do    {������������롱������ֻ�жӳ�������ʾ}
    begin
      ComboBox4.Items.Add(Fieldbyname('����').AsString+'('+Fieldbyname('ѧ��ѧ��').AsString+')');  {�������������}
      next;
    end;
  end;

  {���ϵ������ݿ��������}
  ADODataSetjs.CommandText:='select ��������,��������,���쵥λ,��ʼʱ��,����ʱ��,��ӹ��� from ����';
  ADODataSetjs.Open;
  ADODataSetzdls.CommandText:='select ָ����ʦ.����, ����, ѧԺ����, �ֻ���, ְ�� from ָ����ʦ,ѧԺ where ָ����ʦ.ѧԺ����=ѧԺ.ѧԺ����';
  ADODataSetzdls.Open;
  ADODataSetdw.CommandText:='select �������,��������,ѧ��.���� as ѧ������,����.��������,ָ����ʦ.���� as ָ����ʦ����,����״̬ from ����,ѧ��,����,ָ����ʦ where ѧ��.ѧ��=����.�ӳ�ѧ�� and ����.��������=����.�������� and ָ����ʦ.����=����.ָ����ʦ����';
  ADODataSetdw.Open;

  with ADOQuery1 do       {��ʾ����Ϊ�ӳ��Ķ���Ķ���״̬���Ƕӳ���Զ��ʾ������С�}
  begin
    SQL.Clear;
    SQL.Add('select ����״̬ from ���� where �ӳ�ѧ��=:wdxh');
    Parameters.ParamByName('wdxh').Value:=wdxh;
    open;
    if Fieldbyname('����״̬').AsString='���ͨ��' then
    begin
      RadioGroup1.ItemIndex:=1;
    end
    else
    begin
      RadioGroup1.ItemIndex:=0;
    end;
  end;
end;



procedure TMainForm1.Button1Click(Sender: TObject);   {��������}
var
  dwmc:string;
  lsxx:string;
  strs:TStrings;
  dwsl:integer;
  dwdh:string;
  jsdh:string;
  zdgh:string;
begin
  dwmc:=trim(Editdwmc.Text);
  jsdh:=trim(ComboBox1.Text);
  lsxx:=trim(ComboBox2.Text);
  if (dwmc='') or (jsdh='') or (lsxx='') then
  begin
    ShowMessage('��Ϣδ��д��ȫ');       {��Ϣ����Ϊ��}
    exit;
  end;


  with ADOQuery1 do
  begin
    {��������}
    SQL.Clear;
    SQL.Add('select count(*) c from ����');
    open;
    dwsl:=Fieldbyname('c').AsInteger+1;
    dwdh:=inttostr(dwsl);      {�����+1}

    strs:=TStringList.Create;
    strs.Delimiter := '(';
    strs.DelimitedText:=lsxx;
    zdgh:=strs[1];
    zdgh:=copy(zdgh,1,10);

    SQL.Clear;
    SQL.Add('insert into ���� values (:dwdh,:dwmc,:dzxh,:jsdh,:zdgh,:zt)');
    Parameters.ParamByName('dwdh').Value:=dwdh;
    Parameters.ParamByName('dwmc').Value:=dwmc;
    Parameters.ParamByName('dzxh').Value:=wdxh;
    Parameters.ParamByName('jsdh').Value:=jsdh;
    Parameters.ParamByName('zdgh').Value:=zdgh;
    Parameters.ParamByName('zt').Value:='�����';
    ExecSQL;
  end;
  
  ShowMessage('�����ɹ�');

  with ADODataSetdw do
  begin
    Close;     {�����ɹ���������ʾ�������ж���}
    CommandText:='select �������,��������,ѧ��.���� as ѧ������,����.��������,ָ����ʦ.���� as ָ����ʦ����,����״̬ from ����,ѧ��,����,ָ����ʦ where ѧ��.ѧ��=����.�ӳ�ѧ�� and ����.��������=����.�������� and ָ����ʦ.����=����.ָ����ʦ����';
    Open;
  end;

  with ADOQuery1 do
  begin
    SQL.Clear;        {���´����Ķ���д�����ݿ�}
    SQL.Add('insert into ���鹹�� values (:dwdh,:wdxh)');
    Parameters.ParamByName('wdxh').Value:=wdxh;
    Parameters.ParamByName('dwdh').Value:=dwdh;
    ExecSQL;
  end;

end;

procedure TMainForm1.Button2Click(Sender: TObject);  {�ύ���밴ť}
var
  dwxx:string;
  dwdh:string;
  strs:TStrings;
begin
  dwxx:=trim(ComboBox3.Text);
  with ADOQuery1 do
  begin
    strs:=TStringList.Create;
    strs.Delimiter := '(';
    strs.DelimitedText:=dwxx;
    dwdh:=strs[1];
    dwdh:=copy(dwdh,1,1);      {��ȡ��ѡ�����Ķ����}

    SQL.Clear;
    SQL.Add('insert into �������� values (:dwdh,:wdxh)');       {�����ݿ��м�¼����}
    Parameters.ParamByName('wdxh').Value:=wdxh;
    Parameters.ParamByName('dwdh').Value:=dwdh;
    ExecSQL;

    ShowMessage('�ύ�ɹ�');
  end;
end;

procedure TMainForm1.Button3Click(Sender: TObject);   {ͬ���������}
var
  xx:string;
  xh:string;
  strs:TStrings;
//  dwdh:string;
begin
  xx:=trim(ComboBox4.Text);           {ɶ��ûѡ�͵�ͬ��}
  if xx='' then
  begin
    ShowMessage('������Ϊ��');
    exit;
  end;
  strs:=TStringList.Create;
  strs.Delimiter := '(';
  strs.DelimitedText:=xx;
  xh:=strs[1];
  xh:=copy(xh,1,10);


  with ADOQuery1 do
  begin
    {������ӵ���д�����ݿ⣬ɾ����������}
    SQL.Clear;
    SQL.Add('insert into ���鹹�� values (:dwdh,:cyxh)');
    Parameters.ParamByName('dwdh').Value:=wddwdh;
    Parameters.ParamByName('cyxh').Value:=xh;
    ExecSQL;

    SQL.Clear;
    SQL.Add('delete from �������� where �������=:dwdh and ��Աѧ��=:cyxh');
    Parameters.ParamByName('dwdh').Value:=wddwdh;
    Parameters.ParamByName('cyxh').Value:=xh;
    ExecSQL;
    
    ShowMessage('��ͬ��');

    ComboBox4.Clear;      {�������������û���������}
    SQL.Clear;
    SQL.Add('select ����,ѧ��.ѧ�� as ѧ�� from ��������,ѧ��,���� where ѧ��.ѧ��=��������.��Աѧ�� and ��������.�������=����.������� and ����.�ӳ�ѧ��=:wdxh');
    Parameters.ParamByName('wdxh').Value:=wdxh;
    open;
    while not eof do
    begin
      ComboBox4.Items.Add(Fieldbyname('����').AsString+'('+Fieldbyname('ѧ��').AsString+')');
      next;
    end;
    
  end;
end;

procedure TMainForm1.Button4Click(Sender: TObject);   {�ܾ��������}
var
  xx:string;
  xh:string;
  strs:TStrings;
//  dwdh:string;
begin
  xx:=trim(ComboBox4.Text);       {ɶ��ûѡ�͵�ܾ�}
  if xx='' then
  begin
    ShowMessage('������Ϊ��');
    exit;
  end;
  strs:=TStringList.Create;
  strs.Delimiter := '(';
  strs.DelimitedText:=xx;
  xh:=strs[1];
  xh:=copy(xh,1,10);
  with ADOQuery1 do
  begin
    {�����ݿ���ɾ����������}
    SQL.Clear;
    SQL.Add('delete from �������� where �������=:dwdh and ��Աѧ��=:cyxh');
    Parameters.ParamByName('dwdh').Value:=wddwdh;
    Parameters.ParamByName('cyxh').Value:=xh;
    ExecSQL;

    ShowMessage('�Ѿܾ�');
    ComboBox4.Clear;

    SQL.Clear;     {�������������û���������}
    SQL.Add('select ����,ѧ��.ѧ�� as ѧ��ѧ�� from ��������,ѧ��,���� where ѧ��.ѧ��=��������.��Աѧ�� and ��������.�������=����.������� and ����.�ӳ�ѧ��=:wdxh');
    Parameters.ParamByName('wdxh').Value:=wdxh;
    open;
    while not eof do
    begin
      ComboBox4.Items.Add(Fieldbyname('����').AsString+'('+Fieldbyname('ѧ��ѧ��').AsString+')');
      next;
    end;
  end;

end;

procedure TMainForm1.Button5Click(Sender: TObject);  {���ұ߲鿴�������}
var
  dwdh:string;
  dwxx:string;
  strs:TStrings;
begin
  dwxx:=trim(ComboBox5.Text);
  strs:=TStringList.Create;
  strs.Delimiter:='(';
  strs.DelimitedText:=dwxx;
  dwdh:=strs[1];
  dwdh:=copy(dwdh,1,1);   {��ȡ����������ѡ��Ķ���Ķ������}

  with ADODataSetdwgc do
  begin
    Close;
    CommandText:='select ����,��Աѧ�� from ���鹹��,ѧ�� where ѧ��.ѧ��=��Աѧ�� and �������=:dwdh';
    Parameters.ParamByName('dwdh').Value:=dwdh;
    Open;
  end;
end;

procedure TMainForm1.Button6Click(Sender: TObject);

begin

  with ADOQuery1 do      {�ύ�������󣬸������ݿ��е����ݣ�������ʾ���ȴ���ˡ�}
  begin
    SQL.Clear;
    SQL.Add('update ���� set ����״̬=:zt where �ӳ�ѧ��=:wdxh');
    Parameters.ParamByName('wdxh').Value:=wdxh;
    Parameters.ParamByName('zt').Value:='�ȴ����';
    ExecSQL;
  end;

  ShowMessage('�ύ��˳ɹ�');

  with ADODataSetdw do
  begin
    Close;     {�����ɹ���������ʾ�������ж���}
    CommandText:='select �������,��������,ѧ��.���� as ѧ������,����.��������,ָ����ʦ.���� as ָ����ʦ����,����״̬ from ����,ѧ��,����,ָ����ʦ where ѧ��.ѧ��=����.�ӳ�ѧ�� and ����.��������=����.�������� and ָ����ʦ.����=����.ָ����ʦ����';
    Open;
  end;


end;

end.
