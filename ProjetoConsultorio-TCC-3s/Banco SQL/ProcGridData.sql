Alter Procedure ProcGridData
(
  @Data date
)
As
Begin

  Select Consultas.CodConsulta As [C�digo],
		 Left(HorarioIni, 5)   As [In�cio],
         Left(HorarioFim, 5)   As [Fim],
         Clientes.Nome         As [Paciente],
         Servicos.Descricao    As [Servi�o],
         Profissionais.Nome    As [Profissional]
  From Consultas
  Inner Join Clientes On Clientes.CodCliente = Consultas.CodCliente
  Inner Join Servicos On Servicos.CodServico = Consultas.CodServico
  Inner Join Profissionais On Profissionais.CodProfis = Consultas.CodProfis
  Where Data = @Data
  and Status = 'A'
  Order By HorarioIni

End