object Form1: TForm1
  Left = 208
  Top = 131
  Width = 1310
  Height = 602
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = Menu1
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object img1: TImage
    Left = 8
    Top = 48
    Width = 601
    Height = 497
  end
  object img2: TImage
    Left = 632
    Top = 48
    Width = 601
    Height = 497
  end
  object btn1: TButton
    Left = 112
    Top = 8
    Width = 145
    Height = 33
    Caption = 'LoadImage1'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 664
    Top = 8
    Width = 145
    Height = 33
    Caption = 'LoadImage2'
    TabOrder = 1
    OnClick = btn2Click
  end
  object od1: TOpenDialog
    Left = 56
    Top = 16
  end
  object Menu1: TMainMenu
    Left = 296
    Top = 32
    object mniFunc1: TMenuItem
      Caption = 'Func'
      object mniDCT1: TMenuItem
        Caption = 'DCT'
        OnClick = mniDCT1Click
      end
      object mniIDCT1: TMenuItem
        Caption = 'IDCT'
        OnClick = mniIDCT1Click
      end
    end
  end
end
