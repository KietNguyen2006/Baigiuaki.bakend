using Microsoft.AspNetCore.Mvc;
using HotelManagement.Models;
using HotelManagement.Repositories;
using System.Threading.Tasks;

namespace HotelManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RoomTypesController : ControllerBase
    {
        private readonly IRoomTypeRepository _roomTypeRepository;

        public RoomTypesController(IRoomTypeRepository roomTypeRepository)
        {
            _roomTypeRepository = roomTypeRepository;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var roomTypes = await _roomTypeRepository.GetAllAsync();
            return Ok(roomTypes);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var roomType = await _roomTypeRepository.GetByIdAsync(id);
            if (roomType == null)
                return NotFound();
            return Ok(roomType);
        }

        [HttpGet("hotel/{hotelId}")]
        public async Task<IActionResult> GetByHotelId(int hotelId)
        {
            var roomTypes = await _roomTypeRepository.GetByHotelIdAsync(hotelId);
            return Ok(roomTypes);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] RoomType roomType)
        {
            var id = await _roomTypeRepository.CreateAsync(roomType);
            return CreatedAtAction(nameof(GetById), new { id }, roomType);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] RoomType roomType)
        {
            if (id != roomType.Id)
                return BadRequest();

            var success = await _roomTypeRepository.UpdateAsync(roomType);
            if (!success)
                return NotFound();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var success = await _roomTypeRepository.DeleteAsync(id);
            if (!success)
                return NotFound();

            return NoContent();
        }
    }
} 