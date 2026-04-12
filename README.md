# flutter_experiments

A personal Flutter playground to explore, test, and refine features, architectures, and UI flows for learning and skill improvement.

# Key Features

## Authentication Flow:-
Complete custom Signup and Login pages.

## Google Integration:-
A "Link with Google" button that securely initializes and fetches the user's Gmail profile data.

## 1-on-1 Chat System:-
Search functionality to find other registered users.
Real-time, private one-to-one chat functionality with a dedicated Chat History page.

## Live eBay Integration:-
A dynamic search bar that fetches and displays real product data from the official eBay API.

## Location-Aware E-Commerce- 
A full Cart and Order system that captures and utilizes real-time GPS coordinates.

## Adaptive UI:-
Fully responsive layout that adjusts seamlessly to different screen sizes and orientations.

#  Project Demo :-
| **Auth & Google Link** | [![View Demo](https://img.shields.io/badge/View_Demo-blue?style=for-the-badge&logo=google)](./assets/demo/1.mp4) |
#### Showcases the custom signup/login and the "Link with Google" button on the dashboard.

| **eBay Search & GPS** | [![View Demo](https://img.shields.io/badge/View_Demo-orange?style=for-the-badge&logo=ebay)](./assets/demo/2.mp4) |

#### Demonstrates fetching real products from the eBay API, adding to cart, and placing orders with real GPS location.

| **1-on-1 Chat** | [![View Demo](https://img.shields.io/badge/View_Demo-green?style=for-the-badge&logo=chat-bubble)](./assets/demo/3.mp4) |

#### A look at finding registered users and engaging in private, real-time messaging.

| **Adaptive UI** | [![View Demo](https://img.shields.io/badge/View_Demo-red?style=for-the-badge&logo=flutter)](./assets/demo/4.mp4) |

#### Shows how the UI seamlessly adjusts across different screen sizes.

## Architecture & Project Structure

```text
lib/
├── src/
│   ├── core/
│   │    ├── layout/         # Responsive scaffold components
│   │    ├── services        # Currency service convert usd rate to inr
│   ├── features/            # Modular app features (Search Items,Cart,Search Users,Orders, Chat, etc.)
│   └── app.dart             # Responsive layout wrapper (AppLayout)
├── firebase_options.dart    # Firebase auto-generated config
└── main.dart                # App entry point





