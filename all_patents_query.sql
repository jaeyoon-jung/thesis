select 
	*
from 
	(
	select
		p.publication_number,
		p.application_number,
		p.country_code,
		p.priority_date,
    p.family_id,
    p.entity_status,
		STRING_AGG(DISTINCT ipcs.code) as ipc_codes,
    STRING_AGG(DISTINCT assignees) as assignees,
    STRING_AGG(DISTINCT uspcs.code) as uspc_codes,
    STRING_AGG(DISTINCT pc.publication_number) as priority_publication_number,
    STRING_AGG(DISTINCT cit.publication_number) as citations,
    STRING_AGG(DISTINCT ah.name) as assignees_harmonized,
    title.text as title_text,
    title.language as title_lang,
    abstract.text as abstract_text,
    abstract.language as abstract_lang
 	FROM
	  `patents-public-data.patents.publications` AS p
  LEFT JOIN UNNEST(p.ipc) AS ipcs
  LEFT JOIN UNNESt(p.uspc) AS uspcs
  LEFT JOIN UNNEST(p.assignee) AS assignees
  LEFT JOIN UNNEST(p.title_localized) AS title
  LEFT JOIN UNNEST(p.abstract_localized) AS abstract
  LEFT JOIN UNNEST(p.priority_claim) AS pc 
  LEFT JOIN UNNEST(p.citation) as cit
  LEFT JOIN UNNEST(p.assignee_harmonized) as ah
	GROUP BY 
    p.publication_number, p.application_number, p.country_code, 
		p.priority_date, p.family_id, p.entity_status, title.text, title.language,
		abstract.text, abstract.language
	)
where 
	ipc_codes LIKE '%A61J1/%' OR ipc_codes LIKE '%A61J3/%' OR
  ipc_codes LIKE '%A61K9/%' OR ipc_codes LIKE '%A61K31/%' OR
  ipc_codes LIKE '%A61K33/%' OR ipc_codes LIKE '%A61K35/%' OR
  ipc_codes LIKE '%A61K36/%' OR ipc_codes LIKE '%A61K41/%' OR
  ipc_codes LIKE '%A61K49/%' OR ipc_codes LIKE '%A61K51/%' OR
  ipc_codes LIKE '%A61K39/%' OR ipc_codes LIKE '%A61K45/%' OR
  ipc_codes LIKE '%A61K47/%' OR ipc_codes LIKE '%A61K48/%' OR
  ipc_codes LIKE '%A61P/%' OR
	uspc_codes LIKE '%424/%' OR uspc_codes LIKE '%514/%' 