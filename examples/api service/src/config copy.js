const config = {
  serverPort: 3005,
  secretsFile: "/secrets/api-service.secrets.json",
  jwtSecretKey: process.env.JWT_SECRET_KEY,
  googleApiKey: process.env.GOOGLE_API_KEY,
}

export default config
