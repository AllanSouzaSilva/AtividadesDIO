using curso.api.Filters;
using curso.api.Models.Usuarios;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;
using System;
using System.Linq;

namespace curso.api.Controllers
{
    [Route("api/v1/usuario")] //Entrega um nome da api com a vaiavel controller. V1: Versionar minha api
    [ApiController] // Assina essa notaS

    public class UsuarioController : ControllerBase //Herda
    {

        //Rota Logar
        [SwaggerResponse(statusCode: 200, description: "Sucesso ao autenticar", Type = typeof(LoginViewModelInput))] //Aonde o status code 200 vai retorna a mensagem sucesso ao autenticar
        [SwaggerResponse(statusCode: 400, description: "Campos obrigatórios", Type = typeof(ValidaCampoViewModelOutput))] //Validação de campo, vai retornar uma lista de erros 
        [SwaggerResponse(statusCode: 500, description: "Erro interno", Type = typeof(ErrorGenericoViewModel))] //Erro generico, erro 500, mostra uma mensagem 
        [HttpPost] //Autenticando o usuário
        [Route("logar")] // Rota da api
        [ValidacaoModelStateCustomizado]
        public IActionResult Logar(LoginViewModelInput loginViewModelInput) //Passando o objeto como paramentro login
        {
            //if (!ModelState.IsValid)
            //{
                //Se o estado do meu model esta invalido, vamos devolver uma Badrequest utilizando o recurso linq, percorrer todas as lista de erro 
                //e vou devolver as mensagens de eerro mensagem.s
               // return BadRequest(new ValidaCampoViewModelOutput(ModelState.SelectMany(sm => sm.Value.Errors).Select(s => s.ErrorMessage)));
            //}
            return Ok(loginViewModelInput);

        }

        //Rota Registrar
        [HttpPost] //Arquitetura rest: Estamos imformando esse rota vai ter o verbo post, vamos ter um retorno de uma create
        [Route("registrar")]
        public IActionResult Registrar(RegistroViewModelInput registroViewModelInput) //Passando o objeto como paramentro login
        {
            //Assim que criamos o usuario agente devolve utilizando as boas praticas da API rest, pra algum dado que agente vai criar
            //devolvemos um status 201, que retorna um usuario criado e que deu tudo certo.
            return Created("", registroViewModelInput);

        }


    }
}
