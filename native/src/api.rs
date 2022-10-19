use serde_json::{Map, Value};
use voronoi::make_polygons;
pub use voronoi::{voronoi, DiagramBound, Point};

fn diagram_bound_from_json(json: &Map<String, Value>) -> Result<DiagramBound, &'static str> {
    return match (json.get("width"), json.get("height")) {
        (Some(width), Some(height)) => {
            let diagram_width = width.as_f64().unwrap();
            let diagram_height = height.as_f64().unwrap();
            Ok(DiagramBound::new(diagram_width, diagram_height))
        }
        _ => Err("invalid json for point"),
    };
}

// create a SerializablePoint from json string
fn point_from_json(json: &Map<String, Value>) -> Result<Point, &'static str> {
    return match (json.get("x"), json.get("y")) {
        (Some(x), Some(y)) => {
            let x = x.as_f64().unwrap();
            let y = y.as_f64().unwrap();
            Ok(Point::new(x, y))
        }
        _ => Err("invalid json for point"),
    };
}

fn point_to_json(point: &Point) -> Map<String, Value> {
    let mut map = Map::new();
    map.insert("x".to_string(), Value::from(point.x()));
    map.insert("y".to_string(), Value::from(point.y()));
    map
}

pub fn get_voronoi(points: Vec<String>, boxsize: String) -> Vec<Vec<String>> {
    let diagram_bound = diagram_bound_from_json(&serde_json::from_str(&boxsize).unwrap()).unwrap();

    let converted_points = points
        .iter()
        .filter_map(|p| {
            let json: Map<String, Value> = serde_json::from_str(p).unwrap();
            point_from_json(&json).ok()
        })
        .collect::<Vec<Point>>();

    let voronoi_diagram_data = voronoi(converted_points, diagram_bound);
    let voronoi_diagram = make_polygons(&voronoi_diagram_data);

    let result = voronoi_diagram
        .iter()
        .map(|v| {
            v.iter()
                .filter_map(|point| {
                    let point_json = point_to_json(&point);
                    let json = serde_json::to_string::<Map<String, Value>>(&point_json);
                    json.ok()
                })
                .collect::<Vec<String>>()
        })
        .collect::<Vec<Vec<String>>>();

    result
}
