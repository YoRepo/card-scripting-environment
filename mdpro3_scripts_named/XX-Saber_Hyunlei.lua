--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: XX-剑士 迅雷  (ID: 2203790)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Warrior
-- Level 6
-- ATK 2300 | DEF 1300
-- Setcode: 4109
--
-- Effect Text:
-- 调整＋调整以外的「X-剑士」怪兽1只以上
-- ①：这张卡同调召唤时，以场上最多3张魔法·陷阱卡为对象才能发动。那些卡破坏。
--[[ __CARD_HEADER_END__ ]]

--XX－セイバー ヒュンレイ
function c2203790.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0x100d),1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2203790,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c2203790.descon)
	e1:SetTarget(c2203790.destg)
	e1:SetOperation(c2203790.desop)
	c:RegisterEffect(e1)
end
function c2203790.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c2203790.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c2203790.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c2203790.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c2203790.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c2203790.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c2203790.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(sg,REASON_EFFECT)
end
