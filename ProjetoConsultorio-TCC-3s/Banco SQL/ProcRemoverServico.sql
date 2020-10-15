Create or Alter Procedure ProcRemoverServico
(
  @CodServico int,
  @MsgRetorno varchar(2000) OUT,
  @IsOk bit OUT
)
As
Begin

  if exists (Select * From Consultas Where CodServico = @CodServico)
  Begin
    Set @MsgRetorno = 'O servi�o n�o pode ser removido pois est� vinculado a consultas dentro do sistema.'
    Select @MsgRetorno
    Set @IsOk = 0
  End
  Else
  Begin
    Delete From Servicos Where CodServico = @CodServico
    Set @MsgRetorno = 'Servi�o removido com sucesso.'
    Select @MsgRetorno
    Set @IsOk = 1
  End

End