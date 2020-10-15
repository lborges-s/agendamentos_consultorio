Alter Procedure ProcInserirProfissional
(
  @Insert       bit           = Null,
  @Update        bit           = Null,
  @CodProfis     int           = Null,
  @Nome          varchar(100)  = Null,
  @CPF           varchar(100)  = Null,
  @Nascimento    date          = Null,
  @CRO           varchar(12)   = Null,
  @Tel1          varchar(100)  = Null,
  @Tel2          varchar(100)  = Null,
  @CEP           varchar(100)  = Null,
  @Rua           varchar(100)  = Null,
  @Numero        int           = Null,
  @Complemento   varchar(100)  = Null,
  @Bairro        varchar(100)  = Null,
  @CodCidade     int           = Null,
  @CodEstado     int           = Null,
  @Email         varchar(100)  = Null,
  @Observacao    varchar(100)  = Null,
  @Ativo         bit           = 1,
  @MsgRetorno    varchar(2000) = Null OUT,
  @IsOk          bit           = Null OUT
)
As
Begin
  if (@Insert = 1)
  Begin
    if not exists (Select 1 From Profissionais Where CPF = @CPF)
      Begin
        Insert Into Profissionais(Nome,CPF,Nascimento,CRO,Tel1,Tel2,CEP,Rua,Numero,Complemento,Bairro,CodCidade,Cidade,CodEstado,Estado,Email,Observacao,Ativo)
        Select @Nome        As Nome,
               @CPF            As CPF,
               @Nascimento  As Nascimento,
               @CRO         As CRO,
               @Tel1          As Tel1,
               @Tel2          As Tel2,
               @CEP            As CEP,
               @Rua            As Rua,
               @Numero        As Numero,
               @Complemento As Complemento,
               @Bairro        As Bairro,
               @CodCidade      As CodCidade,
               (Select Cidade.Nome From Cidade Where CodCidade = @CodCidade) As Cidade,
               @CodEstado      As CodEstado,
               (Select Estado.Nome From Estado Where CodEstado = @CodEstado) As Estado,
               @Email          As Email,
               @Observacao  As Observacao,
               @Ativo       As Ativo

        if exists (Select 1 From Profissionais Where CPF = @CPF)
          Begin
            Set @MsgRetorno = 'Profissional inserido com sucesso'
            Set @IsOk = 1
            Select @MsgRetorno
          End
        Else
          Begin
            Set @MsgRetorno = 'Ocorreu um problema ao inserir o profissional, tente novamente'
            Set @IsOk = 0
            Select @MsgRetorno 
          End
      End
      Else
        Begin
          Set @MsgRetorno = 'O CPF informado j� possui cadastro'
          Set @IsOk = 0
          Select @MsgRetorno
        End
  End
  if (@Update = 1)
  Begin
        Update Profissionais Set Nome        = @Nome,
                                 Nascimento  = @Nascimento, 
                                 CRO         = @CRO,
                                 Tel1        = @Tel1,       
                                 Tel2        = @Tel2,       
                                 CEP         = @CEP,        
                                 Rua         = @Rua,        
                                 Numero      = @Numero,     
                                 Complemento = @Complemento,
                                 Bairro      = @Bairro,     
                                 CodCidade   = @CodCidade,  
                                 Cidade      = (Select Cidade.Nome From Cidade Where CodCidade = @CodCidade),
                                 CodEstado   = @CodEstado,
                                 Estado      = (Select Estado.Nome From Estado Where CodEstado = @CodEstado),
                                 Email       = @Email,
                                 Observacao  = @Observacao,
                                 Ativo       = @Ativo
    Where CodProfis = @CodProfis
    Set @MsgRetorno = 'Profissional alterado com sucesso'
    Select @MsgRetorno
    Set @IsOk = 1
  End
End
