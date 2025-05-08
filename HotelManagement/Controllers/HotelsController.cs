using Microsoft.AspNetCore.Mvc;
using HotelManagement.Models;
using HotelManagement.Repositories;
using System.Threading.Tasks;

namespace HotelManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class HotelsController : ControllerBase
    {
        private readonly IHotelRepository _hotelRepository;

        public HotelsController(IHotelRepository hotelRepository)
        {
            _hotelRepository = hotelRepository;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var hotels = await _hotelRepository.GetAllAsync();
            return Ok(hotels);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var hotel = await _hotelRepository.GetByIdAsync(id);
            if (hotel == null)
                return NotFound();
            return Ok(hotel);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] Hotel hotel)
        {
            var id = await _hotelRepository.CreateAsync(hotel);
            return CreatedAtAction(nameof(GetById), new { id }, hotel);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] Hotel hotel)
        {
            if (id != hotel.Id)
                return BadRequest();

            var success = await _hotelRepository.UpdateAsync(hotel);
            if (!success)
                return NotFound();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var success = await _hotelRepository.DeleteAsync(id);
            if (!success)
                return NotFound();

            return NoContent();
        }
    }
} 