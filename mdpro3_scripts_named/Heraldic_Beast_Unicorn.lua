--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Heraldic Beast Unicorn  (ID: 45705025)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level: 4
-- ATK 1100 | DEF 1600
-- Setcode: 0x76
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can banish this card from your GY, then target 1 Psychic Xyz Monster in your GY; Special Summon
-- it, but negate its effects.
-- You can only use this effect of "Heraldic Beast Unicorn" once per turn.
--[[ __CARD_HEADER_END__ ]]

--紋章獣ユニコーン
function c45705025.initial_effect(c)
	--revive
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45705025,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,45705025)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c45705025.target)
	e1:SetOperation(c45705025.operation)
	c:RegisterEffect(e1)
end
function c45705025.filter(c,e,tp)
	return c:IsRace(RACE_PSYCHO) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c45705025.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c45705025.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c45705025.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler(),e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c45705025.filter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c45705025.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
end
