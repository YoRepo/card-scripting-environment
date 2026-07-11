--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Transcicada  (ID: 1799464)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Insect
-- Level: 3
-- ATK 800 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Special Summoned: You can Special Summon 1 "Moult Token" (Insect/EARTH/Level 3/ATK
-- 0/DEF 0).
-- While the Token Special Summoned by this effect is on the field, you cannot Special Summon monsters
-- from the Extra Deck, except Insect monsters.
-- You can only use this effect of "Transcicada" once per turn.
--[[ __CARD_HEADER_END__ ]]

--トランシケーダ
function c1799464.initial_effect(c)
	--spsummon token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1799464,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,1799464)
	e1:SetTarget(c1799464.sptg)
	e1:SetOperation(c1799464.spop)
	c:RegisterEffect(e1)
end
function c1799464.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,1799465,0,TYPES_TOKEN_MONSTER,0,0,3,RACE_INSECT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c1799464.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,1799465,0,TYPES_TOKEN_MONSTER,0,0,3,RACE_INSECT,ATTRIBUTE_EARTH) then
		local token=Duel.CreateToken(tp,1799465)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetAbsoluteRange(tp,1,0)
		e1:SetTarget(c1799464.splimit)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		token:RegisterEffect(e1,true)
		Duel.SpecialSummonComplete()
	end
end
function c1799464.splimit(e,c)
	return not c:IsRace(RACE_INSECT) and c:IsLocation(LOCATION_EXTRA)
end
