--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 魔轰神兽 刻耳柏拉  (ID: 82888408)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Beast
-- Level 2
-- ATK 1000 | DEF 400
-- Setcode: 53
--
-- Effect Text:
-- ①：这张卡从手卡丢弃去墓地的场合发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--魔轟神獣ケルベラル
function c82888408.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82888408,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c82888408.spcon)
	e1:SetTarget(c82888408.sptg)
	e1:SetOperation(c82888408.spop)
	c:RegisterEffect(e1)
end
function c82888408.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and bit.band(r,REASON_DISCARD)~=0
end
function c82888408.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c82888408.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
