unit DCTUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TDouble2DArray = array of array of Double;
  TInt2DArray = array of array of Integer;

  TForm1 = class(TForm)
    img1: TImage;
    od1: TOpenDialog;
    btn1: TButton;
    img2: TImage;
    btn2: TButton;
    DCT: TButton;
    idct: TButton;
    mm1: TMemo;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DCTClick(Sender: TObject);
    procedure idctClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  {$i DCT_H.inc}

var
  Form1: TForm1;
  isImg1Loaded, isImg2Loaded : Boolean;
  dctMatrix1, dctMatrix2: TDouble2DArray;
  Xstep, Ystep : Integer;
  N : Integer;

implementation

{$R *.dfm}

{$i DCT_IMP.inc}

procedure TForm1.btn1Click(Sender: TObject);
begin
    if od1.Execute = True then
    begin
        img1.Picture.Bitmap.LoadFromFile(od1.FileName);
        isImg1Loaded := true;
    end;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
    if od1.Execute = True then
    begin
        img2.Picture.Bitmap.LoadFromFile(od1.FileName);
        isImg2Loaded := true;
    end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    isImg1Loaded := false;
    isImg2Loaded := false;

    //暫時直接指定影像路徑
    isImg1Loaded := true;
    isImg2Loaded := true;
    img1.Picture.Bitmap.LoadFromFile('C:\Users\WenJuChen\Pictures\DCT\Pentagon1.bmp');
    img2.Picture.Bitmap.LoadFromFile('C:\Users\WenJuChen\Pictures\DCT\Pentagon2.bmp');

    N := 8;
end;

procedure TForm1.DCTClick(Sender: TObject);
var
    img1Buf, img2Buf: TImage;
    i, j : Integer;
    str: String;
    ImgSL: PByteArray;
begin
    cloneImgSetting(img1Buf, img1);
    cloneImgSetting(img2Buf, img2);

    for j:=0 to 10 do
    begin
        ImgSL := img1.Picture.Bitmap.ScanLine[j];
        str := '';
        for i:=0 to 10 do
        begin
            str := str + IntToStr(ImgSL[i*3]) + ' ';
        end;
        Form1.mm1.Lines.Add(str);
    end;
    Form1.mm1.Lines.Add(' ');       
    
    SetLength(dctMatrix1, img1Buf.Picture.Bitmap.Width);

    SetLength(dctMatrix2, img2Buf.Picture.Bitmap.Width);
    
    for i:=0 to img1Buf.Picture.Bitmap.Width-1 do
    begin
        SetLength(dctMatrix1[i], img1Buf.Picture.Bitmap.Height);
    end;
    for i:=0 to img2Buf.Picture.Bitmap.Width-1 do
    begin
        SetLength(dctMatrix2[i], img2Buf.Picture.Bitmap.Height);
    end;

    dctTypeII(img1.Picture.Bitmap, img1Buf.Picture.Bitmap, dctMatrix1, 3);
    dctTypeII(img2.Picture.Bitmap, img2Buf.Picture.Bitmap, dctMatrix2, 3);

    img1.Picture.Bitmap.Assign(img1Buf.Picture.Bitmap);
    img2.Picture.Bitmap.Assign(img2Buf.Picture.Bitmap);

end;

procedure TForm1.idctClick(Sender: TObject);
var
    i, j: Integer;
    ImgSL: PByteArray;
    str: String;
    img1Buf, img2Buf: TImage;
begin
    cloneImgSetting(img1Buf, img1);
    cloneImgSetting(img2Buf, img2);

    idctTypeII(img1.Picture.Bitmap, img1Buf.Picture.Bitmap, dctMatrix1, 3);
    idctTypeII(img2.Picture.Bitmap, img2Buf.Picture.Bitmap, dctMatrix2, 3);

    img1.Picture.Bitmap.Assign(img1Buf.Picture.Bitmap);
    img2.Picture.Bitmap.Assign(img2Buf.Picture.Bitmap);

    for j:=0 to 10 do
    begin
        ImgSL := img1.Picture.Bitmap.ScanLine[j];
        str := '';
        for i:=0 to 10 do
        begin
            str := str + IntToStr(ImgSL[i*3]) + ' ';
        end;
        Form1.mm1.Lines.Add(str);
    end;
    Form1.mm1.Lines.Add(' ');
end;

end.
