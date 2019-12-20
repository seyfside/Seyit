using System.Threading.Tasks;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using Seyit.Business.Airways.Query;

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
    }
}