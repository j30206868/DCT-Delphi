function dctConst(value, Nstep: Integer): double;
function dctCosX(x, u, xN: Integer; pi: double): double;
function dctCosY(y, v, yN: Integer; pi: double): double;
function pixelGuard(value: Integer):Integer;

procedure dctTypeIIBlockCalc(sX, sY, xN, yN: Integer; tarBmp, bufBmp: TBitmap ; var dctMatrix: TDouble2DArray ; bpp: Integer);
procedure idctTypeIIBlockCalc(sX, sY, xN, yN: Integer; bufBmp: TBitmap ; dctMatrix: TDouble2DArray ; bpp: Integer);

procedure dctTypeII(tarBmp, bufBmp: TBitmap ; dctMatrix: TDouble2DArray ; bpp: Integer);
procedure idctTypeII(tarBmp, bufBmp: TBitmap ; dctMatrix: TDouble2DArray ; bpp: Integer);

procedure cloneImgSetting(var clonee:TImage; template:TImage);