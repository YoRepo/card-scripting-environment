--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Magnet Reverse  (ID: 80352158)
-- Type: Spell / Quick-Play
-- Setcode: 0x1d9
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 of your Machine or Rock monsters, that is banished or is in your GY, that cannot be Normal
-- Summoned/Set; Special Summon it.
--[[ __CARD_HEADER_END__ ]]

--マグネット・リバース
function c80352158.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c80352158.target)
	e1:SetOperation(c80352158.activate)
	c:RegisterEffect(e1)
end
function c80352158.filter(c,e,tp)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE+RACE_ROCK) and not c:IsSummonableCard()
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c80352158.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and c80352158.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c80352158.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c80352158.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c80352158.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
