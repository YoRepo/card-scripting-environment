--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Chewbone  (ID: 7392745)
-- Type: Monster / Effect / Flip
-- Attribute: EARTH
-- Race: Zombie
-- Level: 3
-- ATK 300 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Special Summon 3 "Chewbone Jr. Tokens" (Zombie-Type/EARTH/Level 1/ATK 100/DEF 300) to your
-- opponent's field in Defense Position.
--[[ __CARD_HEADER_END__ ]]

--チュウボーン
function c7392745.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7392745,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c7392745.target)
	e1:SetOperation(c7392745.operation)
	c:RegisterEffect(e1)
end
function c7392745.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c7392745.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<3 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,7392746,0,TYPES_TOKEN_MONSTER,100,300,1,RACE_ZOMBIE,ATTRIBUTE_EARTH,POS_FACEUP_DEFENSE,1-tp) then return end
	for i=1,3 do
		local token=Duel.CreateToken(tp,7392746)
		Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
	end
	Duel.SpecialSummonComplete()
end
