
Create or Alter Procedure ProcGridPeriodo
(
  @DataIni date,
  @DataFim date
)
As
Begin

  Select Consultas.Data        As [Data],
         Left(HorarioIni, 5)   As [Inicio],
		 Left(HorarioFim, 5)   As [Fim],
         Consultas.CodConsulta As [C�digo], 
         Clientes.Nome         As [Paciente],
         Servicos.Descricao    As [Servi�o],
         Profissionais.Nome    As [Profissional]
  From Consultas
  Inner Join Clientes On Clientes.CodCliente = Consultas.CodCliente
  Inner Join Servicos On Servicos.CodServico = Consultas.CodServico
  Inner Join Profissionais On Profissionais.CodProfis = Consultas.CodProfis
  Where Data between @DataIni and @DataFim
  and Status = 'A'
  Order By 1,2

End
