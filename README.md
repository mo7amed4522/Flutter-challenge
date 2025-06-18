# Flutter Code Challenge  

⚠️ Please note excessive use of AI will disqualify an assessment from review. ⚠️

**🚖 Flutter Code Challenge: Ride-Hailing App UI**    
**Objective**: Build a responsive, multi-screen Flutter app matching the provided designs (\`**001.jpg\` and \`01.jpg\`**). Focus on UI fidelity, navigation, and optional interactivity.  

**📋 Core Requirements**    
1\. **Home Screen** (Based on \`01.jpg\`)  

* **Header**: Greeting ("Hi, Michael") with a clean layout.    
* **Service Tabs:** Horizontal scrollable tabs: **Ride, Delivery, Eats, Flights**.    
* **Promo Banner:** "20% OFF ON YOUR NEXT RIDE" with styled background.    
* **Community Events Section:**    
  * List events with dates (e.g., **\*"Sun, May 3 – Carmichael Farmer Market"**\*).    
* **Bottom Nav Bar:** Icons for \***Home, Orders, Messages\*** (active tab highlighted).  

2\. **Ride Selection Screen** (Based on \`001.jpg\`)  

* **Location Bar**: "FAV," "SAN," and "5 mins" indicators.    
* **Pickup/Dropoff**:    
  * Wheble Reston East" (pickup)    
  *  WMATA Metro Station" (dropoff)    
* **Vehicle Options:**    
  *  Types: **Economy, Luxury, Taxicab** (selectable).    
  *   Sizes: **Small, Medium, Large** (with prices: \*$35.50, $50.00, $150.43\*).    
  * Estimated times: **3–5 mins** (per option).    
* **Car Details**: License plate (\*"V83\*\*\*7539"\*), "Now" badge.    
* **Button**: "Book this Car" (styled as shown).  

✨ **Bonus Tasks (Optional)**  

* **Interactivity**:\*\*    
  * Highlight selected vehicle options (e.g., change border color).    
  * Animate the "Book this Car" button on press (e.g., scale effect).    
* **Navigation**:    
  *  Tapping **Ride** on the Home Screen navigates to the Ride Selection Screen.    
* **State Management**:    
  *  Use **Provider**/**Riverpod**/**Bloc** to manage selected ride type/size.    
* **Responsiveness**:    
  * Adapt layouts for tablets (e.g., grid view for vehicle options).  

**📤 Submission Guidelines**    
1\. **Code** **Quality**:  

* Use reusable widgets (avoid monolithic code).    
* Follow Dart/Flutter best practices (null safety, proper folder structure).  

2\. **Documentation**:  

* README.md\` with:    
* How to run the app.    
* Dependencies used (if any).    
* Brief explanation of your approach.  

3\. **Delivery**:  

* Share a **GitHub repo** of the full project.  

 **Time Estimate:**  

* Basic Implementation: 2–3 hours    
* With Bonus Features: 4–5 hours  

**Design Notes for the Developer**  

* **Fonts**: Use \***Google Fonts**\* (e.g., \`Roboto\` or \`SF Pro\` if exact fonts are unknown).    
* **Colors**: Extract from the images (e.g., use a color picker tool).    
* **Icons**: Use \`flutter\_icons\` or \`Material Icons\` for tab bars.  

**Example Starter Code Snippet (Optional to Include**)\*\*    
---

```dart  
// Example for the Ride Selection Screen vehicle selector:  
ListView.builder(  
  itemCount: rideOptions.length,  
  itemBuilder: (ctx, index) \=\> GestureDetector(  
    onTap: () \=\> setState(() \=\> \_selectedRide \= index),  
    child: Container(  
      decoration: BoxDecoration(  
        border: \_selectedRide \== index   
          ? Border.all(color: Colors.blue, width: 2\)   
          : null,  
      ),  
      child: RideOptionWidget(rideOptions\[index\]),  
    ),  
  ),  
)  
```
---

**Evaluation Criteria**    
1\. **UI Accuracy** (70%): How closely the app matches the designs.    
2\. **Functionality** (20%): Navigation, selection states, button actions.    
3\. **Code Quality** (10%): Structure, readability, scalability.  
