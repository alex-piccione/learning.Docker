// this is ok for configuration, but not for secrets
const config = {
    serverPort: 3005,
    jwtSecretKey: process.env.JWT_SECRET_KEY,
    googleApiKey: process.env.GOOGLE_API_KEY,    
}

export default { ...config }