namespace HotelManagement.Models
{
    public class RoomType
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public decimal Price { get; set; }
        public int HotelId { get; set; }
    }
}
