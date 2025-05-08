using Dapper;
using HotelManagement.Models;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace HotelManagement.Repositories
{
    public class RoomTypeRepository : IRoomTypeRepository
    {
        private readonly DapperContext _context;

        public RoomTypeRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<RoomType>> GetAllAsync()
        {
            using (var connection = _context.CreateConnection())
            {
                return await connection.QueryAsync<RoomType>("spGetAllRoomTypes", 
                    commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<RoomType> GetByIdAsync(int id)
        {
            using (var connection = _context.CreateConnection())
            {
                return await connection.QueryFirstOrDefaultAsync<RoomType>(
                    "spGetRoomTypeById",
                    new { Id = id },
                    commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<IEnumerable<RoomType>> GetByHotelIdAsync(int hotelId)
        {
            using (var connection = _context.CreateConnection())
            {
                return await connection.QueryAsync<RoomType>(
                    "spGetRoomTypesByHotelId",
                    new { HotelId = hotelId },
                    commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<int> CreateAsync(RoomType roomType)
        {
            using (var connection = _context.CreateConnection())
            {
                var parameters = new DynamicParameters();
                parameters.Add("Name", roomType.Name);
                parameters.Add("Price", roomType.Price);
                parameters.Add("HotelId", roomType.HotelId);

                return await connection.QuerySingleAsync<int>(
                    "spAddRoomType",
                    parameters,
                    commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<bool> UpdateAsync(RoomType roomType)
        {
            using (var connection = _context.CreateConnection())
            {
                var parameters = new DynamicParameters();
                parameters.Add("Id", roomType.Id);
                parameters.Add("Name", roomType.Name);
                parameters.Add("Price", roomType.Price);
                parameters.Add("HotelId", roomType.HotelId);

                var affected = await connection.ExecuteAsync(
                    "spUpdateRoomType",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return affected > 0;
            }
        }

        public async Task<bool> DeleteAsync(int id)
        {
            using (var connection = _context.CreateConnection())
            {
                var affected = await connection.ExecuteAsync(
                    "spDeleteRoomType",
                    new { Id = id },
                    commandType: CommandType.StoredProcedure);

                return affected > 0;
            }
        }
    }
} 