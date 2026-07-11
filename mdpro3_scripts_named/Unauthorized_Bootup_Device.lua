--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Unauthorized Bootup Device  (ID: 81951640)
-- Type: Monster / Effect / Union
-- Attribute: DARK
-- Race: Machine
-- Level: 1
-- ATK 500 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can either: Target 1 face-up monster you control; equip this card to that target,
-- OR: Unequip this card and Special Summon it.
-- If the equipped monster would be destroyed by battle or card effect, destroy this card instead.
-- If this card is destroyed and sent to the GY while equipped to a monster: You can Special Summon
-- this card.
-- You can only use this effect of "Unauthorized Bootup Device" once per turn.
--[[ __CARD_HEADER_END__ ]]

--奇動装置メイルファクター
function c81951640.initial_effect(c)
	aux.EnableUnionAttribute(c,aux.TRUE)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(81951640,2))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCountLimit(1,81951640)
	e4:SetCondition(c81951640.con)
	e4:SetTarget(c81951640.tg)
	e4:SetOperation(c81951640.op)
	c:RegisterEffect(e4)
end
function c81951640.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_SZONE) and c:GetPreviousEquipTarget() and not c:IsReason(REASON_LOST_TARGET)
end
function c81951640.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c81951640.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
