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
		if (triggered)
		{
			dissolveMat.SetFloat("_DissolveAmount", Mathf.Lerp(0.0f, 1.0f, 10));
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		StartCoroutine(Dissolve());
	}

	private IEnumerator Dissolve()
	{
		triggered = true;
		yield return new WaitForSeconds(1);
		gameObject.SetActive(false);
	}
}
