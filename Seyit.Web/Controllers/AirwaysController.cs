using System;
using System.Threading.Tasks;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using Seyit.Business.Airways.Command;
using Seyit.Business.Airways.Query;
using Seyit.Data.Airways;

namespace Seyit.Web.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AirwaysController : ControllerBase
    {
        private readonly IMediator _mediator;

        public AirwaysController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll([FromQuery]GetAllAirwaysQuery query)
        {
            var result=await _mediator.Send(query);
            
            return Ok(result);
        }

        [HttpPost]

        public async Task<IActionResult> Create(CreateAirwayCommand command)
        {
            var id = await _mediator.Send(command);

            return Created(String.Empty, id);
        }
    }
}