class_name SpinnerConfig

enum SpinnerType {
	Plus1,
	Plus5Minues1
}

const AREA_RADIUS = 62

const AREAS_PER_TYPE = {
	SpinnerType.Plus1 : [
		{
			"type": SpinnerArea.AreaType.EMPTY,
			"amount": 0,
			"start_angle": -270.0,
			"end_angle": -90.0,
			"color": Color("ededed"),
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.EARN_FIXED,
			"start_angle": -90.0,
			"end_angle": 90.0,
			"color": Color("458600"),
			"amount": 1,
			"radius": AREA_RADIUS
		}
	],
	SpinnerType.Plus5Minues1 : [
		{
			"type": SpinnerArea.AreaType.LOSE_FIXED,
			"amount": 1,
			"start_angle": -150.0,
			"end_angle": -90.0,
			"color": Color("d31930"),
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.EMPTY,
			"amount": 0,
			"start_angle": -270.0,
			"end_angle": -150.0,
			"color": Color("ededed"),
			"radius": AREA_RADIUS
		},
		{
			"type": SpinnerArea.AreaType.EARN_FIXED,
			"start_angle": -90.0,
			"end_angle": 90.0,
			"color": Color("458600"),
			"amount": 5,
			"radius": AREA_RADIUS
		}
	]
}
