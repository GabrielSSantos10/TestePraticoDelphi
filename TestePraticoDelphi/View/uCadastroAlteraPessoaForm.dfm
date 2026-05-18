object uCadastrarAlterarPessoaForm: TuCadastrarAlterarPessoaForm
  Left = 0
  Top = 0
  Caption = 'uCadastrarAlterarPessoaForm'
  ClientHeight = 519
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object lblNomePessoa: TLabel
    Left = 8
    Top = 40
    Width = 95
    Height = 15
    Caption = 'Nome completo*:'
  end
  object lblCPF: TLabel
    Left = 8
    Top = 107
    Width = 29
    Height = 15
    Caption = 'CPF*:'
  end
  object lblRG: TLabel
    Left = 200
    Top = 107
    Width = 18
    Height = 15
    Caption = 'RG:'
  end
  object lblEmail: TLabel
    Left = 368
    Top = 107
    Width = 42
    Height = 15
    Caption = 'E-mail*:'
  end
  object lblCEP: TLabel
    Left = 8
    Top = 296
    Width = 29
    Height = 15
    Caption = 'CEP*:'
  end
  object lblBairro: TLabel
    Left = 8
    Top = 363
    Width = 39
    Height = 15
    Caption = 'Bairro*:'
  end
  object lblLogradouro: TLabel
    Left = 200
    Top = 296
    Width = 70
    Height = 15
    Caption = 'Logradouro*:'
  end
  object lblCidade: TLabel
    Left = 368
    Top = 363
    Width = 45
    Height = 15
    Caption = 'Cidade*:'
  end
  object lblTituloDadosPessoais: TLabel
    Left = 8
    Top = 8
    Width = 85
    Height = 15
    Caption = 'Dados Pessoais:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTituloEndereco: TLabel
    Left = 8
    Top = 264
    Width = 55
    Height = 15
    Caption = 'Endere'#231'o:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTipoPessoa: TLabel
    Left = 8
    Top = 184
    Width = 87
    Height = 15
    Caption = 'Tipo de pessoa*:'
  end
  object lblTelefone: TLabel
    Left = 368
    Top = 184
    Width = 53
    Height = 15
    Caption = 'Telefone*:'
  end
  object lblDataNascimento: TLabel
    Left = 200
    Top = 184
    Width = 113
    Height = 15
    Caption = 'Data de nascimento*:'
  end
  object lblEstado: TLabel
    Left = 576
    Top = 363
    Width = 43
    Height = 15
    Caption = 'Estado*:'
  end
  object edtNomePessoa: TEdit
    Left = 8
    Top = 61
    Width = 721
    Height = 23
    TabOrder = 0
  end
  object edtMaskCPF: TMaskEdit
    Left = 8
    Top = 136
    Width = 142
    Height = 23
    EditMask = '000.000.000\-00;0;_'
    MaxLength = 14
    TabOrder = 1
    Text = ''
  end
  object edtRG: TEdit
    Left = 200
    Top = 136
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object edtMaskEmail: TMaskEdit
    Left = 368
    Top = 136
    Width = 361
    Height = 23
    TabOrder = 3
    Text = ''
  end
  object edtLogradouro: TEdit
    Left = 200
    Top = 317
    Width = 529
    Height = 23
    TabOrder = 4
  end
  object cmbTipoPessoa: TComboBox
    Left = 8
    Top = 205
    Width = 145
    Height = 23
    TabOrder = 5
  end
  object dtPckDataNascimento: TDateTimePicker
    Left = 200
    Top = 205
    Width = 121
    Height = 23
    Date = 46158.000000000000000000
    Time = 0.492971782405220400
    TabOrder = 6
  end
  object edtMaskTelefone: TMaskEdit
    Left = 368
    Top = 205
    Width = 355
    Height = 23
    EditMask = '!\(00\) 00000\-0000;0;_'
    MaxLength = 15
    TabOrder = 7
    Text = ''
  end
  object edtMaskCEP: TMaskEdit
    Left = 8
    Top = 317
    Width = 142
    Height = 23
    EditMask = '00000\-000;0;_'
    MaxLength = 9
    TabOrder = 8
    Text = ''
    OnExit = edtMaskCEPExit
  end
  object edtBairro: TEdit
    Left = 8
    Top = 392
    Width = 313
    Height = 23
    TabOrder = 9
  end
  object edtCidade: TEdit
    Left = 368
    Top = 392
    Width = 161
    Height = 23
    TabOrder = 10
  end
  object edtEstado: TEdit
    Left = 576
    Top = 392
    Width = 153
    Height = 23
    TabOrder = 11
  end
  object btnSalvarAlterar: TButton
    Left = 339
    Top = 448
    Width = 117
    Height = 33
    Caption = 'Salvar'
    TabOrder = 12
    OnClick = btnSalvarAlterarClick
  end
  object btnExcluir: TButton
    Left = 475
    Top = 448
    Width = 117
    Height = 33
    Caption = 'Excluir'
    TabOrder = 13
    OnClick = btnExcluirClick
  end
  object btnCancelar: TButton
    Left = 612
    Top = 448
    Width = 117
    Height = 33
    Caption = 'Cancelar'
    TabOrder = 14
    OnClick = btnCancelarClick
  end
  object btnEditar: TButton
    Left = 8
    Top = 448
    Width = 117
    Height = 33
    Caption = 'Editar'
    TabOrder = 15
    OnClick = btnEditarClick
  end
end
