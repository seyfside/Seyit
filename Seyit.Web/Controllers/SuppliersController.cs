using System;
using System.Threading.Tasks;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using Seyit.Business.Airways.Command;
using Seyit.Business.Suppliers.Command;
using Seyit.Business.Suppliers.Query;
using Seyit.Data.Suppliers;

namespace Seyit.Web.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SuppliersController : ControllerBase
    {
        private readonly IMediator _mediator;

        public SuppliersController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        public async Task<IActionResult> GetCombos()
        {
            return Ok(await _mediator.Send(new GetSupplierCombosQuery()));
        }

        [HttpPost]
        public async Task<IActionResult> Create(CreateSupplierCommand command)
        {
            var id = await _mediator.Send(command);

            return Created(String.Empty, id);
        }
    }
}