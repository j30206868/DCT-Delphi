function dctConst(value, Nstep: Integer): double;
begin
    if value = 0 then
    begin
        result := sqrt( 1.0/Nstep );
    end
    else
    begin
        result := sqrt( 2.0/Nstep );
    end;
end;

function pixelGuard(value: Integer):Integer;
begin
    if value > 255 then
    begin
        result := 255;
    end
    else if value < 0 then
    begin
        result := 0;
    end
    else
    begin
        result := value;
    end;
end;

function dctCosX(x, u, xN: Integer; pi: double): double;
begin
    result := cos( ( pi*(2*x+1)*u )/(2.0*xN) );
end;

function dctCosY(y, v, yN: Integer; pi: double): double;
begin
    result := cos( ( pi*(2*y+1)*v )/(2.0*yN) );
end;

procedure dctTypeIIBlockCalc(sX, sY, xN, yN: Integer; tarBmp, bufBmp: TBitmap ; var dctMatrix: TDouble2DArray ; bpp: Integer);
var
    pi: Double;
    u, v, x, y: Integer;
    bufPV, tarPV, uIdx, xIdx: Integer;
    sum: Double;
    bufSL, tarSL: PByteArray;
begin
    pi := 3.14159;

    for v:=0 to yN-1 do
    begin
        bufSL := bufBmp.ScanLine[v + sY];

        for u:=0 to xN-1 do
        begin
            sum := 0;

            for y:=0 to yN-1 do
            begin
                tarSL := tarBmp.ScanLine[y + sY];

                for x:=0 to xN-1 do
                begin
                    //convert value range from 0~255 to -128~127
                    // so -128
                    xIdx := (x + sX) * bpp;
                    tarPV := tarSL[xIdx];
                    sum := sum + tarPV * dctCosX(x, u, xN, pi) * dctCosY(y, v, yN, pi);
                end;
            end;

            dctMatrix[u + sX][v + sY] := dctConst(u, xN) * dctConst(v, yN) * sum;
            //convert range back
            // + 128
            bufPV := Round( dctMatrix[u + sX][v + sY] );
            bufPV := pixelGuard(bufPV);
            uIdx := (u + sX) * bpp;

            bufSL[uIdx] := bufPV;
            bufSL[uIdx+1] := bufPV;
            bufSL[uIdx+2] := bufPV;
        end;
    end;
end;

procedure idctTypeIIBlockCalc(sX, sY, xN, yN: Integer; bufBmp: TBitmap ; dctMatrix: TDouble2DArray ; bpp: Integer);
var
    pi: Double;
    u, v, x, y: Integer;
    bufPV, xIdx: Integer;
    sum: Double;
    bufSL: PByteArray;
begin
    pi := 3.14159;

    for y:=0 to yN-1 do
    begin
        bufSL := bufBmp.ScanLine[y + sY];

        for x:=0 to xN-1 do
        begin
            sum := 0;

            for v:=0 to yN-1 do
            begin
                for u:=0 to xN-1 do
                begin
                    sum := sum + dctConst(u, xN) * dctConst(v, yN) * dctMatrix[u + sX][v + sY] * dctCosX(x, u, xN, pi) * dctCosY(y, v, yN, pi);
                end;
            end;

            bufPV := Round( sum );
            //bufPV := pixelGuard(bufPV);
            xIdx := (x + sX) * bpp;

            bufSL[xIdx]   := bufPV;
            bufSL[xIdx+1] := bufPV;
            bufSL[xIdx+2] := bufPV;
        end;
    end;
end;

procedure dctTypeII(tarBmp, bufBmp: TBitmap ; dctMatrix: TDouble2DArray ; bpp: Integer);
var
    xS, xE, yS, yE: Integer;
    wBorder, hBorder: Integer;
begin
    Xstep := N;
    Ystep := N;
                                  
    wBorder := Round((tarBmp.Width mod Xstep) / 2.0);
    hBorder := Round((tarBmp.Height mod Ystep) / 2.0);

    xS := wBorder;
    xE := xS + Xstep - 1; //起使那點也要算 所以減1

    while (xE <= 220) do
    begin
        yS := hBorder;
        yE := yS + Ystep - 1;

        while (yE <= 220) do
        begin
            dctTypeIIBlockCalc(xS, yS, Xstep, Ystep, tarBmp, bufBmp, dctMatrix, bpp);

            //繼續此column的下一個block
            yS := yS + Ystep;
            yE := yS + Ystep - 1; //起使那點也要算 所以減1
        end;

        //繼續此row的下一個block
        xS := xS + Xstep;
        xE := xS + Xstep - 1; //起使那點也要算 所以減1
    end;
end;

procedure idctTypeII(tarBmp, bufBmp: TBitmap ; dctMatrix: TDouble2DArray ; bpp: Integer);
var
    Xstep, Ystep : Integer;
    xS, xE, yS, yE: Integer;
    wBorder, hBorder: Integer;
begin
    Xstep := N;
    Ystep := N;

    wBorder := Round((tarBmp.Width mod Xstep) / 2.0);
    hBorder := Round((tarBmp.Height mod Ystep) / 2.0);

    xS := wBorder;
    xE := xS + Xstep - 1; //起使那點也要算 所以減1

    while (xE <= 220) do
    begin
        yS := hBorder;
        yE := yS + Ystep - 1;

        while (yE <= 220) do
        begin
            idctTypeIIBlockCalc(xS, yS, Xstep, Ystep, bufBmp, dctMatrix, bpp);

            //繼續此column的下一個block
            yS := yS + Ystep;
            yE := yS + Ystep - 1; //起使那點也要算 所以減1
        end;

        //繼續此row的下一個block
        xS := xS + Xstep;
        xE := xS + Xstep - 1; //起使那點也要算 所以減1
    end;
end;

procedure cloneImgSetting(var clonee:TImage; template:TImage);
begin
     clonee := TImage.Create(Form1);
     clonee.Picture.Bitmap.PixelFormat := template.Picture.Bitmap.PixelFormat;
     clonee.Picture.Bitmap.Width := template.Picture.Bitmap.Width;
     clonee.Picture.Bitmap.Height := template.Picture.Bitmap.Height;
end;
