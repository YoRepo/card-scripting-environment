--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 法老之灵  (ID: 25343280)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Zombie
-- Level 6
-- ATK 2500 | DEF 2000
--
-- Effect Text:
-- 这张卡不能进行通常召唤。这张卡只能通过「第一之棺」的效果进行特殊召唤。这张卡特殊召唤成功时，可以从自己的墓地里特殊召唤至多4只2星以下的不死族通常怪兽上场。
--[[ __CARD_HEADER_END__ ]]

--スピリッツ・オブ・ファラオ
function c25343280.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--Negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(25343280,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c25343280.target)
	e2:SetOperation(c25343280.operation)
	c:RegisterEffect(e2)
end
function c25343280.spfilter(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsLevelBelow(2) and c:IsRace(RACE_ZOMBIE)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c25343280.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c25343280.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c25343280.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>4 then ft=4 end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c25343280.spfilter,tp,LOCATION_GRAVE,0,1,ft,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c25343280.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<g:GetCount() then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) and g:GetCount()>1 then return end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
