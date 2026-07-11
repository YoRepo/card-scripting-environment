--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Cosmic Compass  (ID: 27450400)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 1
-- ATK 100 | DEF 300
-- Setcode: 0xf2
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned: You can Special Summon a number of "Compass Tokens"
-- (Machine/EARTH/Level 1/ATK 0/DEF 0) up to the number of monsters your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--クラスター・ペンデュラム
function c27450400.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27450400,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c27450400.sptg)
	e1:SetOperation(c27450400.spop)
	c:RegisterEffect(e1)
end
function c27450400.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,27450401,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_MACHINE,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c27450400.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	if ft>ct then ft=ct end
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,27450401,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_MACHINE,ATTRIBUTE_EARTH) then return end
	local ctn=true
	while ft>0 and ctn do
		local token=Duel.CreateToken(tp,27450401)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		ft=ft-1
		if ft<=0 or not Duel.SelectYesNo(tp,aux.Stringid(27450400,1)) then ctn=false end
	end
	Duel.SpecialSummonComplete()
end
