package com.example.activitypointstracker.utils;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class PointCalculator {

    private static final Map<String, Map<String, Object>> pointData = new HashMap<>();

    static {
        // Data initialization
        Map<String, Object> entrepreneurship = new HashMap<>();
        entrepreneurship.put("Products Developed", 60);
        entrepreneurship.put("Start-up Company (Registered legally)", 60);
        entrepreneurship.put("Patent-Filed", 30);
        entrepreneurship.put("Patent-Published", 35);
        entrepreneurship.put("Patent-Approved", 50);
        entrepreneurship.put("Patent-Licensed", 80);
        entrepreneurship.put("Prototype developed and tested", 60);
        entrepreneurship.put("Awards for Products developed", 60);
        entrepreneurship.put("Innovative Technologies (Developed and used by industries/users)", 60);
        entrepreneurship.put("Got Venture Capital Funding (For innovative ideas/products)", 80);
        entrepreneurship.put("Startup Employment", 80);
        entrepreneurship.put("Societal Innovations", 50);
        pointData.put("Entrepreneurship & Innovation", entrepreneurship);

        Map<String, Object> leadership = new HashMap<>();
        leadership.put("Core Coordinator", 15);
        leadership.put("Sub Coordinator", 10);
        leadership.put("Volunteer", 5);
        leadership.put("Maximum Points", 40);
        pointData.put("Leadership & Management", leadership);

        Map<String, Object> nationalInitiatives = new HashMap<>();
        nationalInitiatives.put("NCC", Map.of("Points", 60, "Duration (Years)", 2));
        nationalInitiatives.put("NSS", Map.of("Points", 60, "Duration (Years)", 2));
        pointData.put("National Initiatives Participation", nationalInitiatives);

        Map<String, Object> sportsAndGames = new HashMap<>();
        sportsAndGames.put("Participation", Map.of("Level I", 8, "Level II", 15, "Level III", 25, "Level IV", 40, "Level V", 60));
        sportsAndGames.put("First Prize", Map.of("Level I", 10, "Level II", 10, "Level III", 10, "Level IV", 20, "Level V", 20));
        sportsAndGames.put("Second Prize", Map.of("Level I", 8, "Level II", 8, "Level III", 8, "Level IV", 16, "Level V", 16));
        sportsAndGames.put("Third Prize", Map.of("Level I", 5, "Level II", 5, "Level III", 5, "Level IV", 12, "Level V", 12));
        sportsAndGames.put("Maximum Points", 60);
        pointData.put("Sports & Games Participation", sportsAndGames);

        Map<String, Object> culturalActivities = new HashMap<>();
        culturalActivities.put("Music", Map.of("Level I", 8, "Level II", 12, "Level III", 20, "Level IV", 40, "Level V", 60));
        culturalActivities.put("Performing Arts", Map.of("Level I", 8, "Level II", 12, "Level III", 20, "Level IV", 40, "Level V", 60));
        culturalActivities.put("Literary Arts", Map.of("Level I", 8, "Level II", 12, "Level III", 20, "Level IV", 40, "Level V", 60));
        culturalActivities.put("First Prize", Map.of("Level I", 10, "Level II", 10, "Level III", 10, "Level IV", 20, "Level V", 20));
        culturalActivities.put("Second Prize", Map.of("Level I", 8, "Level II", 8, "Level III", 8, "Level IV", 16, "Level V", 16));
        culturalActivities.put("Third Prize", Map.of("Level I", 5, "Level II", 5, "Level III", 5, "Level IV", 12, "Level V", 12));
        culturalActivities.put("Maximum Points", 60);
        pointData.put("Cultural Activities Participation", culturalActivities);

        Map<String, Object> professionalSelfInitiatives = new HashMap<>();
        professionalSelfInitiatives.put("Tech Fest", Map.of("Level I", 10, "Level II", 20, "Level III", 30, "Level IV", 40, "Level V", 50));
        professionalSelfInitiatives.put("MOOC with Final Assessment Certificate", 50);
        professionalSelfInitiatives.put("Competitions by Professional Bodies", Map.of("Level I", 10, "Level II", 15, "Level III", 20, "Level IV", 30, "Level V", 40, "Maximum Points", 40));
        professionalSelfInitiatives.put("Conference/Seminar Attendance (IITs/NITs)", 20);
        professionalSelfInitiatives.put("Paper Presentation/Publication (IITs/NITs)", 30);
        professionalSelfInitiatives.put("Poster Presentation/Publication (IITs/NITs)", 20);
        professionalSelfInitiatives.put("Industrial Training/Internship (5+ days)", 20);
        professionalSelfInitiatives.put("Industrial/Exhibition Visits", 5);
        professionalSelfInitiatives.put("Foreign Language Skill (TOEFL/IELTS/BEC)", 50);
        pointData.put("Professional Self Initiatives", professionalSelfInitiatives);
    }

    public int calculatePoints(String category, String subCategory, String levelOrRole) {
        Map<String, Object> categoryData = pointData.get(category);
        if (categoryData == null) {
            throw new IllegalArgumentException("Invalid category: " + category);
        }

        // Custom logic based on the category
        switch (category) {
            case "Leadership & Management":
                Integer leadershipPoints = (Integer) categoryData.get(levelOrRole);
                if (leadershipPoints != null) {
                    return leadershipPoints;
                } else {
                    throw new IllegalArgumentException("Invalid level or role for Leadership & Management: " + levelOrRole);
                }

            case "Entrepreneurship & Innovation":
                Integer entrepreneurshipPoints = (Integer) categoryData.get(subCategory);
                if (entrepreneurshipPoints != null) {
                    return entrepreneurshipPoints;
                } else {
                    throw new IllegalArgumentException("Invalid subcategory for Entrepreneurship & Innovation: " + subCategory);
                }

            case "National Initiatives Participation":
                // Handle the "National Initiatives Participation" case
                Object nationalInitiativeData = categoryData.get(subCategory);
                if (nationalInitiativeData instanceof Map) {
                    Map<String, Object> initiativeData = (Map<String, Object>) nationalInitiativeData;
                    Object points = initiativeData.get("Points");
                    if (points instanceof Integer) {
                        return (Integer) points;
                    } else {
                        throw new IllegalArgumentException("Invalid data for National Initiatives Participation (Points): " + points);
                    }
                }
                throw new IllegalArgumentException("Invalid subcategory for National Initiatives Participation: " + subCategory);

            case "Sports & Games Participation":
            case "Cultural Activities Participation":
            case "Professional Self Initiatives":
                // Handle the nested structure for these categories
                Object subCategoryData = categoryData.get(subCategory);
                if (subCategoryData instanceof Integer) {
                    return (Integer) subCategoryData;
                } else if (subCategoryData instanceof Map) {
                    @SuppressWarnings("unchecked")
                    Map<String, Integer> levelMap = (Map<String, Integer>) subCategoryData;
                    Integer points = levelMap.get(levelOrRole);
                    if (points != null) {
                        return points;
                    } else {
                        throw new IllegalArgumentException("Invalid level or role: " + levelOrRole);
                    }
                }
                throw new IllegalArgumentException("Invalid subcategory: " + subCategory);

            default:
                throw new IllegalArgumentException("Unhandled category: " + category);
        }
    }


}
