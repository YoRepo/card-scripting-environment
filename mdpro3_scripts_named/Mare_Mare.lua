--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Mare Mare  (ID: 54537489)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Wyrm
-- Level: 7
-- ATK 2100 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned, except by the effect of a Wyrm monster.
-- During your Main Phase: You can reduce this card's Level by 1, and if you do, Special Summon 1 "Mini
-- Mare Mare Token" (Wyrm/WATER/Level 1/ATK 300/DEF 200).
-- You can only use this effect of "Mare Mare" up to thrice per turn.
--[[ __CARD_HEADER_END__ ]]

--タツノオトシオヤ
function c54537489.initial_effect(c)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c54537489.splimit)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(54537489,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(3,54537489)
	e2:SetTarget(c54537489.sptg)
	e2:SetOperation(c54537489.spop)
	c:RegisterEffect(e2)
end
function c54537489.splimit(e,se,sp,st)
	return se:IsActiveType(TYPE_MONSTER) and se:GetHandler():IsRace(RACE_WYRM)
end
function c54537489.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsLevelAbove(2)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,54537490,0,TYPES_TOKEN_MONSTER,300,200,1,RACE_WYRM,ATTRIBUTE_WATER) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c54537489.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsImmuneToEffect(e) or c:IsLevel(1) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	e1:SetValue(-1)
	c:RegisterEffect(e1)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,54537490,0,TYPES_TOKEN_MONSTER,300,200,1,RACE_WYRM,ATTRIBUTE_WATER) then
		local token=Duel.CreateToken(tp,54537490)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
