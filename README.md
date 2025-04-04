# Players4Players 🎮

## About the Project

Players4Players is a platform designed for gamers with limited free time who still want to enjoy multiplayer experiences. The platform connects players in similar situations, allowing them to find companions for co-op gameplay and organize gaming sessions that fit their schedules.

### Built With
* Ruby on Rails
* JavaScript/Stimulus
* PostgreSQL
* Bootstrap
* Action Cable for real-time chat
* Cloudinary for image hosting
* FreeToGame API for game data

## Features

### 📚 Game Library
- Browse a comprehensive database of free online games 
- Search games by name, category or platform
- View detailed game information including summaries, developers, and release dates

### 📋 Game Lists
- Create personalized game collections
- Organize games by category, preference, or any criteria you choose
- Filter games by category when creating lists

### 🎲 Game Sessions
- Schedule gaming sessions with specific games, dates, and times
- Join existing sessions created by other players
- Each session includes a real-time chat for coordination and planning

### 💬 Real-time Chat
- Integrated chat system in each game session
- Communicate with other players to coordinate gameplay
- Discuss strategies and share gaming tips

### 👤 User Profiles
- Customize your player profile
- View your game collections and scheduled sessions
- Track your ratings and reviews

### ⭐ Rating System
- Rate games you've played
- Read reviews from other players
- Find highly rated games to try next

## Getting Started

### Prerequisites
- Ruby 3.0.0 or higher
- Rails 6.1 or higher
- PostgreSQL 13.0 or higher
- Node.js & Yarn

### Installation

1. Clone the repository
   ```sh
   git clone https://github.com/gabsgarcia/players4players.git
   ```

2. Install required gems
   ```sh
   bundle install
   ```

3. Install JavaScript dependencies
   ```sh
   yarn install
   ```

4. Setup the database
   ```sh
   rails db:create db:migrate db:seed
   ```

5. Start the Rails server
   ```sh
   rails s
   ```

6. Visit `http://localhost:3000` in your browser

## Development Process

This project was developed as the final project for the Le Wagon Bootcamp Full Stack Web Developer program. It was created using the Le Wagon Rails template with Devise for authentication.

## Future Enhancements

- Game session matchmaking based on player skills
- Integration with gaming platforms for automatic session setup
- In-app notifications for upcoming gaming sessions
- Friend recommendations based on gaming preferences
- Mobile app version

## Contributors

- [Your Name](https://github.com/yourusername) - Full Stack Developer

## Acknowledgements

- [Le Wagon Coding Bootcamp](https://www.lewagon.com) for providing the education and support
- [FreeToGame API](https://www.freetogame.com/api-doc) for the game data
- [Font Awesome](https://fontawesome.com) for the icons
