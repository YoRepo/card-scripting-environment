--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 黑魔术骑士  (ID: 50725996)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Warrior
-- Level 7
-- ATK 2500 | DEF 2100
-- Setcode: 4258
--
-- Effect Text:
-- 这张卡不能通常召唤。「骑士的称号」的效果才能特殊召唤。
-- ①：这张卡特殊召唤成功的场合，以场上1张卡为对象发动。那张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ブラック・マジシャンズ・ナイト
function c50725996.initial_effect(c)
	c:EnableReviveLimit()
	--special summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--des
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c50725996.destg)
	e2:SetOperation(c50725996.desop)
	c:RegisterEffect(e2)
end
function c50725996.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c50725996.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
