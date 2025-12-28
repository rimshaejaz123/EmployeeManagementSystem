<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Identity Card</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            background-color: #1e1e2f;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            font-family: 'Poppins', sans-serif;
        }

        .id-card-container {
            width: 350px;
            height: 560px;
            background: #ffffff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0,0,0,0.6);
            text-align: center;
            position: relative;
            flex-shrink: 0;
            background-image: radial-gradient(#e6e6e6 1px, transparent 1px);
            background-size: 20px 20px;
        }

        .card-header {
            background: linear-gradient(135deg, #0061ff 0%, #60efff 100%);
            height: 150px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            clip-path: polygon(0 0, 100% 0, 100% 85%, 0% 100%);
        }

        .company-name {
            font-size: 24px;
            font-weight: 800;
            letter-spacing: 1px;
            text-transform: uppercase;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .profile-img-box {
            width: 130px;
            height: 130px;
            background: white;
            border-radius: 50%;
            border: 5px solid white;
            margin: -75px auto 10px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
            position: relative;
            z-index: 10;
        }

        .profile-img-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .name-container {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 5px;
        }

        .name { font-size: 22px; font-weight: 700; color: #2c3e50; }
        .verified-icon { color: #0061ff; font-size: 18px; }

        .designation {
            color: #7f8c8d;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 25px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 12px;
            padding: 0 40px;
            text-align: left;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #eee;
            padding-bottom: 8px;
            font-size: 13px;
        }

        .label { color: #aaa; font-weight: 500; }
        .value { color: #333; font-weight: 600; }

        .barcode {
            margin-top: 30px;
            font-family: 'Courier New', monospace;
            font-weight: 900;
            font-size: 24px;
            letter-spacing: 4px;
            opacity: 0.8;
            transform: scaleY(0.7);
        }

        .print-actions {
            width: 100%;
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }

        .btn-print {
            background: linear-gradient(135deg, #0061ff 0%, #60efff 100%);
            color: white;
            padding: 12px 35px;
            border-radius: 50px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            font-size: 16px;
            box-shadow: 0 4px 15px rgba(0, 97, 255, 0.4);
            transition: transform 0.2s;
        }
        .btn-print:hover { transform: translateY(-2px); }

        @media print {
            body { background: none; -webkit-print-color-adjust: exact; display: block; }
            .print-actions { display: none !important; }
            .id-card-container {
                box-shadow: none; border: 1px solid #ddd;
                position: absolute; top: 50%; left: 50%;
                transform: translate(-50%, -50%);
            }
        }
    </style>
</head>
<body>

    <div class="id-card-container">
        <div class="card-header">
            <i class="fa-solid fa-layer-group" style="font-size: 30px; margin-bottom: 5px; opacity: 0.8;"></i>
            <div class="company-name">EMS CORP</div>
            <div style="font-size:10px; opacity: 0.9; letter-spacing: 1px;">OFFICIAL EMPLOYEE ID</div>
        </div>

        <div class="profile-img-box">
            <img id="profile-pic" src="" alt="Profile">
        </div>

        <div class="name-container">
            <div class="name">${emp.name}</div>
            <i class="fa-solid fa-circle-check verified-icon" title="Verified Employee"></i>
        </div>
        <div class="designation">${emp.designation}</div>

        <div class="info-grid">
            <div class="info-item"><span class="label">ID NO</span><span class="value" style="color: #0061ff;">${emp.code}</span></div>
            <div class="info-item"><span class="label">DEPT</span><span class="value">${emp.dept}</span></div>
            <div class="info-item"><span class="label">PHONE</span><span class="value">${emp.phone}</span></div>
            <div class="info-item"><span class="label">JOINED</span><span class="value">${emp.joined}</span></div>
        </div>

        <div class="barcode">||| |||| || |||</div>
        <div style="font-size:9px; letter-spacing: 1px; color: #999;">${emp.code}</div>
    </div>

    <div class="print-actions">
        <button onclick="window.print()" class="btn-print"><i class="fa-solid fa-print"></i> &nbsp; Print Card</button>
    </div>

    <script>
        // 1. Get the Employee Name & Convert to Lowercase
        var empName = "${emp.name}".toLowerCase();
        
        // 2. Generate a Consistent Image ID from the Employee Code
        var empCodeStr = "${emp.code}"; 
        var imgId = empCodeStr.replace(/\D/g, ''); // Removes "EMS-"
        if (imgId === "") imgId = "1"; 
        
        var portraitNum = parseInt(imgId) % 90; 

        // 3. FEMALE NAMES LIST
        var femaleNames = [
            "sanam", "shaista", "ushna", "neelam", "saba", "bushra", "sadaf", 
            "syra", "ayeza", "sarah", "nida", "hira", "zara", "minal", "aiman", 
            "urwa", "mawra", "iqra", "maya", "mehwish", "mahira", "yumna", 
            "sajal", "kubra", "hania", "momina", "maryam", "hina", "sana", 
            "ayesha", "zainab", "fatima", "rimsha", "bibi", "begum", "bano", "nawaz"
        ];

        // 4. Check if name is Female
        var isFemale = false;
        for (var i = 0; i < femaleNames.length; i++) {
            if (empName.includes(femaleNames[i])) {
                isFemale = true;
                break;
            }
        }

        // 5. Assign the Photo
        var imgElement = document.getElementById("profile-pic");

        // --- SPECIFIC OVERRIDE FOR RIMSHA ---
        if (empName.includes("rimsha ejaz") || empName.includes("rimsha")) {
            imgElement.src = "images/rimsha.jpg"; 
        } 
        // --- WOMEN ---
        else if (isFemale) {
            imgElement.src = "https://randomuser.me/api/portraits/women/" + portraitNum + ".jpg";
        } 
        // --- MEN (Default) ---
        else {
            imgElement.src = "https://randomuser.me/api/portraits/men/" + portraitNum + ".jpg";
        }
    </script>

</body>
</html>