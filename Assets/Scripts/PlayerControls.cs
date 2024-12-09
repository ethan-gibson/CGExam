
using UnityEngine;

public class PlayerControls : MonoBehaviour
{
	[SerializeField] private Vector3 offset;
	[SerializeField] private float speed;
	[SerializeField] private float rotationSpeed;

	void Start()
	{
		
	}

	// Update is called once per frame
	void Update()
	{
		Move();
	}

	private void Move()
	{
		if (Input.GetKey(KeyCode.W))
		{
			transform.position += transform.up * speed * Time.deltaTime;
		}
		if (Input.GetKey(KeyCode.S))
		{
			transform.position -= transform.up * speed * Time.deltaTime;
		}
		if (Input.GetKey(KeyCode.D))
		{
			transform.localEulerAngles -= new Vector3(0, 0, rotationSpeed * Time.deltaTime);
		}
		if (Input.GetKey(KeyCode.A))
		{
			transform.localEulerAngles += new Vector3(0, 0, rotationSpeed * Time.deltaTime);
		}
	}
}