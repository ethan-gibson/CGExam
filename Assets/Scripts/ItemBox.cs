using System.Collections;
using UnityEngine;

public class ItemBox : MonoBehaviour
{
	[SerializeField] private float rotateSpeed;
	[SerializeField] private Material dissolveMat;
	private bool triggered;
	private void Start()
	{
		dissolveMat.SetFloat("_DissolveAmount", 0);
	}
	void Update()
	{
		transform.localEulerAngles += new Vector3(0, rotateSpeed * Time.deltaTime, 0);
	}

	private void OnTriggerEnter(Collider other)
	{
		StartCoroutine(Dissolve());
	}

	private IEnumerator Dissolve()
	{
		float time = 0.0f;
		while (time < 0.5)
		{
			dissolveMat.SetFloat("_DissolveAmount", time * 2);
			time += Time.deltaTime;
			yield return null;
		}
		gameObject.SetActive(false);
	}
}
