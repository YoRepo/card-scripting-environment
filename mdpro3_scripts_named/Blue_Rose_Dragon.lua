--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Blue Rose Dragon  (ID: 98884569)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level: 4
-- ATK 1600 | DEF 1200
-- Setcode: 0x1123
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card on the field is destroyed and sent to the GY: You can target 1 "Black Rose Dragon" or
-- 1 Plant monster in your GY; Special Summon that monster.
--[[ __CARD_HEADER_END__ ]]

--ブルーローズ・ドラゴン
function c98884569.initial_effect(c)
	aux.AddCodeList(c,73580471)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98884569,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c98884569.condition)
	e1:SetTarget(c98884569.target)
	e1:SetOperation(c98884569.operation)
	c:RegisterEffect(e1)
end
function c98884569.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c98884569.filter(c,e,tp)
	return (c:IsRace(RACE_PLANT) or c:IsCode(73580471)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c98884569.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c98884569.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c98884569.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c98884569.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c98884569.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
