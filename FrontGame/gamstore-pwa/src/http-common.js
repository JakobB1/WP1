import axios from "axios";  


export default axios.create({
    baseURL: "https://jakobb1-001-site1.gtempurl.com/api/v1",
    headers: {
        "Content-Type": "application/json"
    }
});